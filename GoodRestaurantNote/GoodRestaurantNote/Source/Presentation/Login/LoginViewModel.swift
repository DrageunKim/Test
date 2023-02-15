//
//  LoginViewModel.swift
//  GoodRestaurantNote
//
//  Created by yonggeun Kim on 2023/02/15.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseCore
import KakaoSDKAuth
import KakaoSDKUser
import FacebookLogin
import GoogleSignIn

class LoginViewModel {
    
    func loginKakao(completion: @escaping () -> Void) {
        if (UserApi.isKakaoTalkLoginAvailable()) {
            UserApi.shared.loginWithKakaoTalk { oauthToken, error in
                if let error = error {
                    print(error)
                    return
                }
                
                self.loginInFirebase()
                completion()
//                                let kakaoToken = oauthToken?.idToken
//                                self.configureKakaoSign(token: kakaoToken)
            }
        } else {
            UserApi.shared.loginWithKakaoAccount { oauthToken, error in
                if let error = error {
                    print(error)
                    return
                }
                
                self.loginInFirebase()
                completion()
//                let kakaoToken = oauthToken?.idToken
//                self.configureKakaoSign(token: kakaoToken)
            }
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
            
            if let current = AccessToken.current {
                let credential = FacebookAuthProvider.credential(
                    withAccessToken: current.tokenString
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
    }
    
    func loginGoogle(target: UIViewController, completion: @escaping () -> Void) {
        if let clientID = FirebaseApp.app()?.options.clientID {
            print(clientID)
            let config = GIDConfiguration(clientID: clientID)
            
            GIDSignIn.sharedInstance.signIn(withPresenting: target, hint: config.clientID) { signInResult, error in
                if let error = error {
                    print(error)
                    return
                }
                
                guard let result = signInResult else { return }
                
                if let idToken = result.user.idToken?.tokenString {
                    let accessToken = result.user.accessToken.tokenString
                    let credential = GoogleAuthProvider.credential(
                        withIDToken: idToken,
                        accessToken: accessToken
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
        }
    }
    
    private func loginInFirebase() {
        UserApi.shared.me() { user, error in
            if let error = error {
                print(error)
                return
            }
            if let userNickname = user?.kakaoAccount?.profile?.nickname,
               let userID = user?.id {
                let id = "\(userNickname)@kakaoGoodRestaurantNote.com"
                let password = "\(userID)dragon+GoodRestaurantNote+pw"
                
                Auth.auth().createUser(withEmail: id, password: password) { result, error in
                    if let error = error {
                        print(error)
                        Auth.auth().signIn(withEmail: id, password: password)
                    } else {
                        
                    }
                }
            }
        }
    }
    
    private func configureKakaoSign(token: String?) {
        if let token = token {
            let credential = OAuthProvider.credential(
                withProviderID: "oidc.kakao",
                idToken: token,
                rawNonce: nil
            )
            
            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    print(error)
                    return
                }
            }
        }
    }
}
