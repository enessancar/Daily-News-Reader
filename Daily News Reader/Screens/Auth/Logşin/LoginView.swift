//
//  LoginView.swift
//  Daily News Reader
//
//  Created by Enes Sancar on 19.01.2024.
//

import UIKit
import SnapKit
import Firebase

protocol LoginViewDelegate: AnyObject {
    func forgotPasswordButtonTapped()
    func signInButtonTapped()
    func newUserButtonTapped()
}

final class LoginView: UIView {
    
    weak var delegate: LoginViewDelegate?
    
    //MARK: - Properties
    private let headLabel = TitleLabel(textAlignment: .left, fontSize: FontSize.subHeadline)
    
    lazy var emailTextField = CustomTextField(fieldType: .email)
    lazy var passwordTextField = CustomTextField(fieldType: .password)
    private let infoLabel = SecondaryTitleLabel(fontSize: FontSize.body)
    
    private lazy var signInButton = CustomButton(
        bgColor: .purple1,
        color:  .purple1,
        title: "Sign In",
        fontSize: .big)
    
    private lazy var newUserButton = CustomButton(
        bgColor:.clear ,
        color: .label,
        title: "Sign Up",
        fontSize: .small)
    
    private lazy var forgotPasswordButton = CustomButton(
        bgColor: .clear,
        color: .purple1,
        title: "Forgot Password ?",
        fontSize: .small)
    
    private let viewModel = AuthViewModel()
    private let stackView = UIStackView()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        
        configureHeadLabel()
        configureEmailTextField()
        configurePasswordTextField()
        configureForgotPasswordButton()
        configureSignInButton()
        configureStackView()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func configureHeadLabel() {
        addSubview(headLabel)
        headLabel.text = "Let's sign you in"
        
        headLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview()
        }
    }
    
    private func configureEmailTextField() {
        addSubview(emailTextField)
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(headLabel.snp.bottom).offset(40)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
    }
    
    private func configurePasswordTextField() {
        addSubview(passwordTextField)
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(20)
            make.leading.trailing.height.equalTo(emailTextField)
        }
    }
    
    private func configureForgotPasswordButton() {
        addSubview(forgotPasswordButton)
        
        forgotPasswordButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(10)
            make.trailing.equalTo(passwordTextField.snp.trailing)
        }
        
        let forgotPasswordAction = UIAction { [weak self] _ in
            guard let self else { return }
            self.didTapForgotPassword()
        }
        forgotPasswordButton.addAction(forgotPasswordAction, for: .touchUpInside)
    }
    
    private func configureSignInButton() {
        addSubview(signInButton)
        signInButton.configuration?.cornerStyle = .capsule
        
        signInButton.snp.makeConstraints { make in
            make.top.equalTo(forgotPasswordButton.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
        
        let signInAction = UIAction { [weak self] _ in
            guard let self else { return }
            self.didTapSignIn()
        }
        signInButton.addAction(signInAction, for: .touchUpInside)
    }
    
    private func configureStackView() {
        addSubview(stackView)
        stackView.axis = .horizontal
        
        stackView.addArrangedSubview(infoLabel)
        stackView.addArrangedSubview(newUserButton)
        
        infoLabel.text = "Don't have an account?"
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(signInButton.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }
        
        let newUserAction = UIAction { [weak self] _ in
            guard let self else { return }
            self.didTapNewUser()
        }
        newUserButton.addAction(newUserAction, for: .touchUpInside)
    }
}

extension LoginView {
    private func didTapForgotPassword() {
        delegate?.forgotPasswordButtonTapped()
    }
    
    private func didTapSignIn() {
        delegate?.signInButtonTapped()
    }
    
    private func didTapNewUser() {
        delegate?.newUserButtonTapped()
    }
}
