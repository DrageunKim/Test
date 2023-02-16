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
    
    // MARK: Kakao Login
    
    func loginKakao(completion: @escaping () -> Void) {
        if (UserApi.isKakaoTalkLoginAvailable()) {
            UserApi.shared.loginWithKakaoTalk { oauthToken, error in
                if let error = error {
                    print(error)
                    return
                }
                
                self.loginKakaoFirebaseLogin {
                    completion()
                }
            }
        } else {
            UserApi.shared.loginWithKakaoAccount { oauthToken, error in
                if let error = error {
                    print(error)
                    return
                }
                
                self.loginKakaoFirebaseLogin {
                    completion()
                }
            }
        }
    }
    
    // MARK: Facebook Login
    
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
                
                self.loginFirebase(credential: credential) {
                    completion()
                }
            }
        }
    }
    
    // MARK: Google Login
    
    func loginGoogle(target: UIViewController, completion: @escaping () -> Void) {
        if let clientID = FirebaseApp.app()?.options.clientID {
            print(clientID)
            let config = GIDConfiguration(clientID: clientID)
            
            GIDSignIn.sharedInstance.signIn(
                withPresenting: target,
                hint: config.clientID
            ) { signInResult, error in
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
                    
                    self.loginFirebase(credential: credential) {
                        completion()
                    }
                }
            }
        }
    }
    
    // MARK: Kakao-Firebase Login
    
    private func loginKakaoFirebaseLogin(completion: @escaping () -> Void) {
        UserApi.shared.me() { user, error in
            if let error = error {
                print(error)
                return
            }
            
            guard let userNickname = user?.kakaoAccount?.profile?.nickname,
                  let userID = user?.id else { return }
            let id = "\(userNickname)@kakaoGoodRestaurantNote.com"
            let password = "\(userID)dragon+GoodRestaurantNote+pw"
            
            self.loginInFirebase(id: id, password: password) {
                completion()
            }
        }
    }
            
    // MARK: Firebase Login (ID/PW)
    
    private func loginInFirebase(id: String, password: String, completion: @escaping () -> Void) {
        Auth.auth().createUser(withEmail: id, password: password) { result, error in
            if let error = error {
                print(error)
                Auth.auth().signIn(withEmail: id, password: password) { result, error in
                    if let error = error {
                        print(error)
                    }
                    
                    print("파이어베이스 로그인 성공")
                    completion()
                }
            } else {
                print("파이어베이스 생성 성공")
                completion()
            }
        }
    }
    
    // MARK: Firebase Login (Credential)
    
    private func loginFirebase(credential: AuthCredential, completion: @escaping () -> Void) {
        Auth.auth().signIn(with: credential) { user, error in
            if let error = error {
                print(error)
                return
            }
            
            completion()
        }
    }
}
