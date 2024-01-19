//
//  HelpAndSupportVC.swift
//  Daily News Reader
//
//  Created by Enes Sancar on 19.01.2024.
//

import Foundation
import UIKit
import SnapKit

final class HelpAndSupportView: UIView {
    
    //MARK: - Properties
    private lazy var containerView : UIView = {
        let container = UIView()
        container.backgroundColor = .secondarySystemBackground
        container.layer.cornerRadius = 10
        return container
    }()
    
    private lazy var userImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .userAvatar
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 35
        return imageView
    }()
    
    private lazy var userName: UILabel = {
        let label = UILabel()
        label.text = "Enes Sancar"
        label.font = UIFont.systemFont(ofSize: FontSize.subHeadline)
        return label
    }()
    
    private lazy var userMessage: UILabel = {
        let label = UILabel()
        label.text = "Send you a message"
        label.font = UIFont.systemFont(ofSize: FontSize.body)
        return label
    }()
    
    lazy var sendImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "message.badge.filled.fill")
        imageView.tintColor = MovieColor.playButonBG
        return imageView
    }()
    
    var userEmail: String?
    
    init(userEmail: String) {
        super.init(frame: .zero)
        self.userEmail = userEmail
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func configureUI() {
        addSubview(containerView)
        containerView.addSubviews(userImage, userName, userMessage, sendImage)
        
        configureContainer()
        configureUserImage()
        configureUserName()
        configureUserMessage()
        configureSendImage()
    }
    
    private func configureContainer() {
        containerView.backgroundColor = .tertiarySystemBackground
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func configureUserImage() {
        userImage.snp.makeConstraints { make in
            make.leading.equalTo(containerView.snp.leading).offset(16)
            make.width.height.equalTo(70)
            make.centerY.equalToSuperview()
        }
    }
    
    private func configureUserName() {
        userName.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.top).offset(20)
            make.centerX.equalToSuperview()
        }
    }
    
    private func configureUserMessage() {
        userMessage.snp.makeConstraints { make in
            make.top.equalTo(userName.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
    }
    
    private func configureSendImage() {
        sendImage.snp.makeConstraints { make in
            make.trailing.equalTo(containerView.snp.trailing).offset(-10)
            make.width.height.equalTo(35)
            make.centerY.equalToSuperview()
        }
    }
}

