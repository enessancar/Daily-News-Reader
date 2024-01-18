//
//  AlertVC.swift
//  Daily News Reader
//
//  Created by Enes Sancar on 18.01.2024.
//

import UIKit
import SnapKit

final class AlertVC: UIViewController {
    
    //MARK: - Properties
    private let containerView = AlertContainerView()
    private let titleLabel = TitleLabel(textAlignment: .center, fontSize: 20)
    private let messageLabel = BodyLabel(textAlignment: .center)
    private let actionButton = CustomButton(bgColor: .systemPink, color: .systemPink, title: "Ok", systemImageName: "checkmark.circle")
    
    var alertTitle: String?
    var message: String?
    var buttonTitle: String?
    
    let padding: CGFloat = 20
    
    //MARK: - Init
    init(title: String, message: String, buttonTitle: String) {
        super.init(nibName: nil, bundle: nil)
        self.alertTitle  = title
        self.message     = message
        self.buttonTitle = buttonTitle
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        
        view.addSubviews(containerView, titleLabel, actionButton, messageLabel)
        configureContainerView()
        configureTitleLabel()
        configureActionButton()
        configureMessageLabel()
    }
    
    private func configureContainerView() {
        containerView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(280)
            make.height.equalTo(220)
        }
    }
    
    private func configureTitleLabel() {
        titleLabel.text = alertTitle ?? "Something went wrong"
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.top).offset(padding)
            make.leading.equalTo(containerView.snp.leading).offset(padding)
            make.trailing.equalTo(containerView.snp.trailing).offset(-padding)
            make.height.equalTo(28)
        }
    }
    
    private func configureActionButton() {
        actionButton.setTitle(buttonTitle ?? "Ok", for: .normal)
        
        let action = UIAction { [weak self] _ in
            guard let self else { return }
            self.actionButtonTapped()
        }
        actionButton.addAction(action, for: .touchUpInside)
        
        actionButton.snp.makeConstraints { make in
            make.bottom.equalTo(containerView.snp.bottom).offset(-padding)
            make.leading.equalTo(containerView.snp.leading).offset(padding)
            make.trailing.equalTo(containerView.snp.trailing).offset(-padding)
            make.height.equalTo(44)
        }
    }
    
    private func configureMessageLabel() {
        messageLabel.text = message ?? "Unable to complete request!"
        messageLabel.numberOfLines = 4
        messageLabel.lineBreakMode = .byTruncatingTail
        
        messageLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.trailing.equalTo(actionButton)
            make.bottom.equalTo(actionButton.snp.top).offset(-12)
        }
    }
    
    private func actionButtonTapped() {
        dismiss(animated: true)
    }
}
