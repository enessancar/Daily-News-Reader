//
//  ChangePasswordView.swift
//  Daily News Reader
//
//  Created by Enes Sancar on 20.01.2024.
//

import UIKit
import SnapKit

protocol ChangePasswordViewProtocol: AnyObject {
    func resetButtonTapped()
}

final class ChangePasswordView: UIView {
    
    weak var delegate: ChangePasswordViewProtocol?
    
    //MARK: - Properties
    private lazy var headLabel = TitleLabel(textAlignment: .left, fontSize: 20)
    
    lazy var passwordTextField   = CustomTextField(fieldType: .password)
    lazy var repasswordTextField = CustomTextField(fieldType: .password)
    
    private lazy var resetButton = CustomButton(
        bgColor: .purple1,
        color: .purple1,
        title: "Reset",
        fontSize: .big)
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        
        configureHeadLabel()
        configureTextFields()
        configureResetButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func configureHeadLabel() {
        addSubview(headLabel)
        headLabel.text = "Reset Password"
        
        headLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.equalToSuperview().offset(20)
        }
    }
    
    private func configureTextFields() {
        addSubviews(passwordTextField, repasswordTextField)
        
        passwordTextField.placeholder = "New Passord"
        repasswordTextField.placeholder = "Confirm Password"
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(headLabel.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
        
        repasswordTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
            make.leading.trailing.height.equalTo(passwordTextField)
        }
    }
    
    private func configureResetButton() {
        addSubview(resetButton)
        resetButton.configuration?.cornerStyle = .capsule
        
        resetButton.snp.makeConstraints { make in
            make.top.equalTo(repasswordTextField.snp.bottom).offset(20)
            make.leading.trailing.height.equalTo(passwordTextField)
        }
        
        let resetAction = UIAction { [weak self] _ in
            guard let self else { return }
            self.didTapResetButton()
        }
        resetButton.addAction(resetAction, for: .touchUpInside)
    }
    
    private func didTapResetButton() {
        delegate?.resetButtonTapped()
    }
}
