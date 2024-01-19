//
//  RegisterView.swift
//  Daily News Reader
//
//  Created by Enes Sancar on 18.01.2024.
//

import UIKit
import SnapKit

protocol RegisterViewDelegate: AnyObject {
    func signUpButtonTapped()
    func signInButtonTapped()
}

final class RegisterView: UIView {
    
    weak var delegate: RegisterViewDelegate?
    
    //MARK: - Properties
    private let headLabel = TitleLabel(textAlignment: .left, fontSize: FontSize.subHeadline)
    private let infoLabel = SecondaryTitleLabel(fontSize: FontSize.body)
    private let stackView = UIStackView()
    
    lazy var userNameTextField = CustomTextField(fieldType: .username)
    lazy var emailTextField = CustomTextField(fieldType: .email)
    lazy var passwordTextField = CustomTextField(fieldType: .password)
    lazy var repasswordTextField = CustomTextField(fieldType: .password)
    
    private lazy var signUpButton = CustomButton(bgColor: .purple1, color: .purple1, title: "Sign Up", fontSize: .big)
    private lazy var signInButton = CustomButton(bgColor:.clear ,color: .label, title: "Sign In.", fontSize: .small)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        
        configureHeadLabel()
        configureUsernameTextfield()
        configureEmailTextField()
        configurePasswordTextField()
        configureSignUpButton()
        configureStackView()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func configureHeadLabel() {
        headLabel.text = "Create an account"
        addSubview(headLabel)
        
        headLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing)
        }
    }
    
    private func configureUsernameTextfield() {
        addSubview(userNameTextField)
        
        userNameTextField.snp.makeConstraints { make in
            make.top.equalTo(headLabel.snp.bottom).offset(40)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
    }
    
    private func configureEmailTextField() {
        addSubview(emailTextField)
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(userNameTextField.snp.bottom).offset(20)
            make.leading.trailing.height.equalTo(userNameTextField)
        }
    }
    
    private func configurePasswordTextField() {
        addSubviews(passwordTextField, repasswordTextField)
        repasswordTextField.placeholder = "Repassword"
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(20)
            make.leading.trailing.height.equalTo(userNameTextField)
        }
        
        repasswordTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
            make.leading.trailing.height.equalTo(userNameTextField)
        }
    }
    
    private func configureSignUpButton() {
        addSubview(signUpButton)
        signUpButton.configuration?.cornerStyle = .capsule
        
        signUpButton.snp.makeConstraints { make in
            make.top.equalTo(repasswordTextField.snp.bottom).offset(20)
            make.leading.trailing.height.equalTo(userNameTextField)
        }
        
        let signUpAction = UIAction { [weak self] _ in
            guard let self else { return }
            self.didTapSignUpButton()
        }
        signUpButton.addAction(signUpAction, for: .touchUpInside)
    }
    
    private func configureStackView() {
        addSubview(stackView)
        stackView.axis = .horizontal
        
        stackView.addArrangedSubview(infoLabel)
        stackView.addArrangedSubview(signInButton)
        
        infoLabel.text = "Already have an account?"
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(signUpButton.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }
        
        let signInAction = UIAction { [weak self] _ in
            guard let self else { return }
            self.didTapSignInButton()
        }
        signInButton.addAction(signInAction, for: .touchUpInside)
    }
}

extension RegisterView {
    private func didTapSignUpButton() {
        delegate?.signUpButtonTapped()
    }
    
    private func didTapSignInButton() {
        delegate?.signInButtonTapped()
    }
}
