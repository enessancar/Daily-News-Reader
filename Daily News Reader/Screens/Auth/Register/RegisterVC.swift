//
//  RegisterVC.swift
//  Daily News Reader
//
//  Created by Enes Sancar on 18.01.2024.
//

import UIKit
import SnapKit

final class RegisterVC: UIViewController {
    
    private let registerView = RegisterView()
    private let viewModel = AuthViewModel()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    private func configureView() {
        navigationItem.setHidesBackButton(true, animated: true)
        view.addSubview(registerView)
        
        registerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        registerView.delegate = self
    }
}

extension RegisterVC: RegisterViewDelegate {
    func signInButtonTapped() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    func signUpButtonTapped() {
        guard let username = registerView.userNameTextField.text,
              let email = registerView.emailTextField.text,
              let password = registerView.passwordTextField.text,
              let repassword = registerView.repasswordTextField.text else {
            presentAlert(title: "Error!", message: "Username, email, password, repassword ?", buttonTitle: "Ok")
            return
        }
        guard email.isValidEmail(email: email) else {
            presentAlert(title: "Alert!", message: "Email invalid", buttonTitle: "Ok")
            return
        }
        guard password.isValidPassword(password: password) else {
            
            guard password.count >= 6 else {
                presentAlert(title: "Error!", message: "Password must be at least 6 characters", buttonTitle: "Ok")
                return
            }
            
            guard password.containsDigits(password) else {
                presentAlert(title: "Alert!", message: "Password must contain at least 1 digit", buttonTitle: "Ok")
                return
            }
            
            guard password.containsLowerCase(password) else {
                presentAlert(title: "Alert!", message: "Password must contain at least 1 lowercase character", buttonTitle: "Ok")
                return
            }
            
            guard password.containsUpperCase(password) else {
                presentAlert(title: "Alert!", message: "Password must contain at least 1 uppercase character", buttonTitle: "Ok")
                return
            }
            
            guard password == repassword else {
                presentAlert(title: "Alert!", message: "Password and password repeat are not the same", buttonTitle: "Ok")
                return
            }
            return
        }
        
        viewModel.register(userName: username, email: email, password: password) { [weak self] success, error in
            guard let self else { return }
            
            if success {
                self.presentAlert(title: "Alert!", message: "Registration Successful", buttonTitle: "Ok")
                self.dismiss(animated: true) {
                    let tabBar = MainTabBarController()
                    tabBar.modalPresentationStyle = .fullScreen
                    self.present(tabBar, animated: true)
                }
            } else {
                self.presentAlert(title: "Alert!", message: error, buttonTitle: "Ok")
            }
        }
    }
}
