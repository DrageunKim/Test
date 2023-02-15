//
//  LoginViewController.swift
//  GoodRestaurantNote
//
//  Created by yonggeun Kim on 2023/02/14.
//

import UIKit
import Firebase
import FBSDKCoreKit
import FacebookLogin
import GoogleSignIn
import KakaoSDKUser

class LoginViewController: UIViewController {

    // MARK: Private Properties
    
    private let viewModel: LoginViewModel = LoginViewModel()
    
    private let introduceTopLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline).withSize(20)
        label.text = "   맛집노트"
        label.textAlignment = .left
        label.textColor = .label
        return label
    }()
    private let introduceBottomLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        label.text = "   123"
        label.textAlignment = .left
        label.textColor = .brown
        return label
    }()
    private let nonMemberLoginButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .label
        button.setTitle("비회원 로그인", for: .normal)
        button.setTitleColor(UIColor.systemBackground, for: .normal)
        button.layer.cornerRadius = 5
        return button
    }()
    private let kakaoLoginButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "KakaoLogin.png"), for: .normal)
        return button
    }()
    private let facebookLoginButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .blue
        return button
    }()
    private let googleLoginButton: GIDSignInButton = {
        let button = GIDSignInButton()
        button.style = .wide
        return button
    }()
    private let introduceStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .leading
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.backgroundColor = .systemGray4
        stackView.layer.cornerRadius = 10
        stackView.layer.borderColor = UIColor.label.cgColor
        stackView.layer.borderWidth = 2
        return stackView
    }()
    private let loginStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        return stackView
    }()
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureLayout()
        configureButton()
    }
    
    // MARK: Private Methods
    
    private func configureView() {
        view.backgroundColor = .systemBackground
        
        navigationItem.title = "계정 로그인"
    }
    
    private func configureButton() {
        kakaoLoginButton.addTarget(self, action: #selector(tappedKakaoLoginButton), for: .touchDown)
        
        facebookLoginButton.addTarget(self, action: #selector(tappedFacebookLoginButton), for: .touchDown)
        
        googleLoginButton.style = .wide
        googleLoginButton.addTarget(self, action: #selector(tappedGoogleLoginButton), for: .touchDown)
    }
    
    private func setUpStackView() {
        introduceStackView.addArrangedSubview(introduceTopLabel)
        introduceStackView.addArrangedSubview(introduceBottomLabel)
        
        loginStackView.addArrangedSubview(nonMemberLoginButton)
        loginStackView.addArrangedSubview(kakaoLoginButton)
        loginStackView.addArrangedSubview(facebookLoginButton)
        loginStackView.addArrangedSubview(googleLoginButton)
    }
    
    private func configureLayout() {
        setUpStackView()
        
        view.addSubview(introduceStackView)
        view.addSubview(loginStackView)
        
        NSLayoutConstraint.activate([
            introduceStackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            introduceStackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.09),
            introduceStackView.topAnchor.constraint(
                equalTo: view.topAnchor,
                constant: view.frame.size.height * 0.2
            ),
            introduceStackView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: view.frame.size.width * 0.1
            ),
            
            loginStackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            loginStackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.32),
            loginStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginStackView.bottomAnchor.constraint(
                equalTo: view.bottomAnchor,
                constant: view.frame.size.height * -0.1
            )
        ])
    }
}

// MARK: - Action Methods

extension LoginViewController {
    @objc
    private func tappedKakaoLoginButton() {
        viewModel.loginKakao {
            print("카카오 로그인")
        }
    }
    
    @objc
    private func tappedFacebookLoginButton() {
        viewModel.loginFacebook {
            print("페이스북 로그인")
        }
    }
    
    @objc
    private func tappedGoogleLoginButton() {
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { signInResult, error in
            guard error == nil else { return }
            
            // If sign in succeeded, display the app's main content View.
        }
    }
}
