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
        googleButton.center = view.center
        view.addSubview(googleButton)
        
        if let token = AccessToken.current,
           !token.isExpired {
            // User is logged in, do work such as go to next view controller.
        }
    }
}

