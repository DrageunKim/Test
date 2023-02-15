//
//  LoginViewModel.swift
//  GoodRestaurantNote
//
//  Created by yonggeun Kim on 2023/02/15.
//

import Foundation
import FirebaseAuth
import KakaoSDKUser
import FacebookLogin

class LoginViewModel {
    private enum KakaoLoginType {
        case app
        case wep
    }
    
    func loginKakao(completion: @escaping () -> Void) {
        if (UserApi.isKakaoTalkLoginAvailable()) {
            kakaoLogin(type: .app)
        } else {
            kakaoLogin(type: .wep)
        }
    }
    
    func loginFacebook(completion: @escaping () -> Void) {
        let loginManager: LoginManager = LoginManager()
        
        loginManager.logIn(permissions: ["public_profile"], from: nil) { result, error in
            if error != nil {
                print("Facebook Login Process Error : \(String(describing: error))")
                return
            } else if result?.isCancelled == true {
                print("Facebook Login Cancelled")
                return
            }
            
            let credential = FacebookAuthProvider.credential(
                withAccessToken: AccessToken.current!.tokenString
            )

            Auth.auth().signIn(with: credential) { user, error in
                if let error = error {
                    print(error)
                    return
                }

                completion()
            }
        }
    }
    
    private func kakaoLogin(type: KakaoLoginType) {
        switch type {
        case .app:
            UserApi.shared.loginWithKakaoTalk { oauthToken, error in
                if let error = error {
                    print(error)
                } else {
                    _ = oauthToken
                    self.loginInFirebase()
                }
            }
        case .wep:
            UserApi.shared.loginWithKakaoAccount { oauthToken, error in
                if let error = error {
                    print(error)
                } else {
                    _ = oauthToken
                    self.loginInFirebase()
                }
            }
        }
    }
    
    private func loginInFirebase() {
        UserApi.shared.me() { user, error in
            if let error = error {
                print(error)
            } else {
                if let userNickname = user?.kakaoAccount?.profile?.nickname,
                   let userID = user?.id {
                    let id = "\(userNickname)@kakaoGoodRestaurantNote.com"
                    let password = "\(userID)dragon+GoodRestaurantNote+pw"
                    
                    Auth.auth().createUser(withEmail: id, password: password) { result, error in
                        if let error = error {
                            print(error)
                            Auth.auth().signIn(withEmail: id, password: password)
                        }
                    }
                }
            }
        }
    }
}
