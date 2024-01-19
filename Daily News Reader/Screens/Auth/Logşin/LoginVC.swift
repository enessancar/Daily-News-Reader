//
//  LoginVC.swift
//  Daily News Reader
//
//  Created by Enes Sancar on 19.01.2024.
//

import UIKit
import SnapKit
import FirebaseAuth

final class LoginVC: UIViewController {
    
    private let loginView = LoginView()
    private let authViewModel = AuthViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLoginView()
    }
    
    private func setupLoginView() {
        view.addSubview(loginView)
        
        loginView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        loginView.delegate = self
    }
}

extension LoginVC: LoginViewDelegate {
    
    func signInButtonTapped() {
        guard let email = loginView.emailTextField.text,
              let password = loginView.passwordTextField.text else {
            presentAlert(title: "Error!", message: "Email / Password ? ", buttonTitle: "Ok")
            return
        }
        
        guard email.isValidEmail(email: email) else {
            presentAlert(title: "Error!", message: "Email in invalid form ", buttonTitle: "Ok")
            return
        }
        
        guard password.isValidPassword(password: password) else {
            
            guard password.count >= 6 else {
                presentAlert(title: "Error!", message: "Password must be least 6 characters", buttonTitle: "Ok")
                return
            }
            guard password.containsDigits(password) else {
                presentAlert(title: "Error!", message: "Password must be contain at least 1 digits", buttonTitle: "Ok")
                return
            }
            guard password.containsLowerCase(password) else {
                presentAlert(title: "Error", message: "Password must be contain at least 1 lowercase character", buttonTitle: "Ok")
                return
            }
            guard password.containsUpperCase(password) else {
                presentAlert(title: "Error", message: "Password must be contain at least 1 uppercase character", buttonTitle: "Ok")
                return
            }
            return
        }
        
        authViewModel.login(email: email, password: password) { [weak self] success, error in
            guard let self else { return }
            
            if success {
                self.presentAlert(title: "Alert !", message: "Entry Successful 🎉", buttonTitle: "Ok")
                self.dismiss(animated: true) {
                    let tabBar = MainTabBarController()
                    tabBar.modalPresentationStyle = .fullScreen
                    self.present(tabBar, animated: true)
                }
            } else {
                self.presentAlert(title: "Error !", message: error, buttonTitle: "Ok")
            }
        }
    }
    
    func forgotPasswordButtonTapped() {
        let vc = ForgotPasswordVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func newUserButtonTapped() {
        let vc = RegisterVC()
        navigationController?.pushViewController(vc, animated: true)
    }
}

