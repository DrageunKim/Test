//
//  ViewController.swift
//  GoodRestaurantNote
//
//  Created by yonggeun Kim on 2023/02/14.
//

import UIKit
import FacebookLogin
import GoogleSignIn

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        let facebookloginButton = FBLoginButton()
        let googleButton = GIDSignInButton()
        googleButton.addTarget(self, action: #selector(test), for: .touchDown)
        googleButton.style = .standard // .wide .iconOnly
        
        googleButton.center = view.center
        view.addSubview(googleButton)
        
        if let token = AccessToken.current,
           !token.isExpired {
            // User is logged in, do work such as go to next view controller.
        }
    }
    
    @objc
    private func test() {
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { signInResult, error in
            guard error == nil else { return }
            
            // If sign in succeeded, display the app's main content View.
        }
    }
}

