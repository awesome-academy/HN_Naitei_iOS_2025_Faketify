//
//  AuthViewController.swift
//  Faketify
//
//  Created by Nguyen Duc on 8/7/25.
//

import UIKit

class AuthViewController: UIViewController {
    
    public var completionHandlers: ((Bool) -> Void)?

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Log in to Faketify"
        label.font = UIFont.boldSystemFont(ofSize: 28)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    private let emailField: UITextField = {
        let field = UITextField()
        field.placeholder = "Email or username"
        field.backgroundColor = .darkGray
        field.textColor = .white
        field.layer.cornerRadius = 8
        field.setLeftPaddingPoints(12)
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        return field
    }()
    
    private let continueButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Continue", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(didTapContinue), for: .touchUpInside)
        return button
    }()
    
    private let signUpLabel: UILabel = {
        let label = UILabel()
        label.text = "Don't have an account?"
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        return label
    }()
    
    private let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign up for Faketify", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(didTapSignUp), for: .touchUpInside)
        return button
    }()
    
    private func createSocialButton(title: String, icon: UIImage?) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle("  \(title)", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = 25
        button.contentHorizontalAlignment = .left
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        
        if let icon = icon {
            let resizedIcon = icon.resize(to: CGSize(width: 24, height: 24))
            button.setImage(resizedIcon.withRenderingMode(.alwaysOriginal), for: .normal)
            button.imageView?.contentMode = .scaleAspectFit
            button.imageEdgeInsets = UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 8)
            button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 0)
        }

        return button
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Sign In"
        view.backgroundColor = .black
        
        let logo = UIImageView(image: UIImage(named: "faketify_logo"))
        logo.contentMode = .scaleAspectFit
        logo.translatesAutoresizingMaskIntoConstraints = false
        
        let googleButton = createSocialButton(title: "Continue with Google", icon: UIImage(named: "google_icon"))
        let facebookButton = createSocialButton(title: "Continue with Facebook", icon: UIImage(named: "facebook_icon"))
        let appleButton = createSocialButton(title: "Continue with Apple", icon: UIImage(named: "apple_icon"))
        let phoneButton = createSocialButton(title: "Continue with phone number", icon: nil)

        let socialStack = UIStackView(arrangedSubviews: [
            googleButton, facebookButton, appleButton, phoneButton
        ])
        socialStack.axis = .vertical
        socialStack.spacing = 12
        socialStack.distribution = .fillEqually

        let bottomStack = UIStackView(arrangedSubviews: [signUpLabel, signUpButton])
        bottomStack.axis = .vertical
        bottomStack.spacing = 4
        bottomStack.alignment = .center

        [logo, titleLabel, socialStack, emailField, continueButton, bottomStack].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }

        NSLayoutConstraint.activate([
            logo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            logo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logo.heightAnchor.constraint(equalToConstant: 50),
            logo.widthAnchor.constraint(equalToConstant: 50),

            titleLabel.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 10),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            socialStack.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            socialStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            socialStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            socialStack.heightAnchor.constraint(equalToConstant: 200),

            emailField.topAnchor.constraint(equalTo: socialStack.bottomAnchor, constant: 30),
            emailField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            emailField.heightAnchor.constraint(equalToConstant: 44),

            continueButton.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 20),
            continueButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            continueButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            continueButton.heightAnchor.constraint(equalToConstant: 44),

            bottomStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            bottomStack.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }


    @objc private func didTapContinue() {
        completionHandlers?(true)
        navigationController?.popViewController(animated: true)
    }

    @objc private func didTapSignUp() {
        print("Navigate to sign-up screen")
    }
    
    func handleRedirectURL(_ url: URL) {
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
              let code = components.queryItems?.first(where: { $0.name == "code" })?.value else {
            return
        }
        
        print("Code: \(code)")
        
        completionHandlers?(true)
        navigationController?.popViewController(animated: true)
    }

}

extension UITextField {
    func setLeftPaddingPoints(_ amount: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}

extension UIImage {
    func resize(to size: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        draw(in: CGRect(origin: .zero, size: size))
        let resized = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resized ?? self
    }
}
