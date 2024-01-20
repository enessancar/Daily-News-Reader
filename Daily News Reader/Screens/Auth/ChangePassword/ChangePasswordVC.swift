//
//  ChangePasswordVC.swift
//  Daily News Reader
//
//  Created by Enes Sancar on 20.01.2024.
//

import UIKit
import SnapKit

final class ChangePasswordVC: UIViewController {
    
    private let changePasswordView = ChangePasswordView()
    private let authViewModel = AuthViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        view.addSubview(changePasswordView)
        
        changePasswordView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        changePasswordView.delegate = self
    }
}

extension ChangePasswordVC: ChangePasswordViewProtocol {
    func resetButtonTapped() {
        
        guard let password = changePasswordView.passwordTextField.text,
              let rePassword = changePasswordView.repasswordTextField.text else {
            
            presentAlert(title: "Error!", message: "Password or Repassword cannot be empty", buttonTitle: "Ok")
            return
        }
        
        guard password.isValidPassword(password: password) else {
            
            guard password.count >= 6 else {
                presentAlert(title: "Alert!", message: "Password must be at least 6 characters", buttonTitle: "Ok")
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
            
            guard  password == rePassword  else {
                presentAlert(title: "Alert!", message: "Password and password repeat are not the same", buttonTitle: "Ok")
                return
            }
            return
        }
        
        authViewModel.changePassword(password: password) { [weak self] success, error in
            guard let self else { return }
            
            if success {
                changePasswordView.passwordTextField.text = ""
                changePasswordView.repasswordTextField.text = ""
                
                presentAlert(title: "Success", message: "Password change success", buttonTitle: "Ok")
            } else {
                presentAlert(title: "Error!", message: error, buttonTitle: "Ok")
            }
        }
    }
}
