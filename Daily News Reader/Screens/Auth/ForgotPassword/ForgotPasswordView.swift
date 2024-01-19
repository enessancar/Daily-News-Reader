//
//  ForgotPasswordView.swift
//  Daily News Reader
//
//  Created by Enes Sancar on 19.01.2024.
//

import UIKit
import SnapKit

protocol ForgotPasswordViewDelegate: AnyObject {
    func forgotPasswordButtonTapped()
    func signInButtonTapped()
}

final class ForgotPasswordView: UIView {
    
    weak var delegate: ForgotPasswordViewDelegate?
    
    private lazy var headLabel = TitleLabel(textAlignment: .left, fontSize: FontSize.subHeadline)
    
    lazy var emailTextField = CustomTextField(fieldType: .email)
    private let infoLabel = SecondaryTitleLabel(fontSize: FontSize.body)
    private let stackView = UIStackView()
    
    private lazy var sumbitButton = CustomButton(
        bgColor: .purple1,
        color: .purple1,
        title: "Sumbit")
    
    private lazy var signInButton = CustomButton(
        bgColor: .clear,
        color: .label,
        title: "Sign in")
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        
        configureHeadLabel()
        configureEmailTextField()
        configureSumbitButton()
        configureStackView()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func configureHeadLabel() {
        addSubview(headLabel)
        
        headLabel.text = "Forgot Password"
        headLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(25)
            make.leading.equalToSuperview().offset(20)
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
    
    private func configureSumbitButton() {
        addSubview(sumbitButton)
        
        sumbitButton.configuration?.cornerStyle = .capsule
        sumbitButton.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(20)
            make.leading.trailing.height.equalTo(emailTextField)
        }
        
        let sumbitAction = UIAction { [weak self] _ in
            guard let self else { return }
            self.didTapSumbitButton()
        }
        sumbitButton.addAction(sumbitAction, for: .touchUpInside)
    }
    
    private func configureStackView() {
        addSubview(stackView)
        stackView.axis = .horizontal
        
        stackView.addArrangedSubview(infoLabel)
        stackView.addArrangedSubview(signInButton)
        
        infoLabel.text = "Already have an account?"
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(sumbitButton.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }
        
        let signInAction = UIAction { [weak self] _ in
            guard let self else { return }
            self.didTapSignIn()
        }
        signInButton.addAction(signInAction, for: .touchUpInside)
    }
}

extension ForgotPasswordView {
    private func didTapSumbitButton() {
        delegate?.forgotPasswordButtonTapped()
    }
    
    private func didTapSignIn() {
        delegate?.signInButtonTapped()
    }
}
