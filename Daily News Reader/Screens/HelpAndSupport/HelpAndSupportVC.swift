//
//  HelpAndSupportView.swift
//  Daily News Reader
//
//  Created by Enes Sancar on 19.01.2024.
//

import UIKit
import SnapKit
import MessageUI

final class HelpAndSupportVC: UIViewController, MFMailComposeViewControllerDelegate {
    
    private let mailComposer = MFMailComposeViewController()
    
    private let headLabel = TitleLabel(textAlignment: .center, fontSize: FontSize.headline)
    private let descriptionLabel = SecondaryTitleLabel(fontSize: FontSize.subHeadline)
    
    private let getInTouchImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .getInTouch
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private var user = HelpAndSupportView(userEmail: "enes57907@gmail.com")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemGroupedBackground
        
        configureGetInTouchImage()
        configureHeadText()
        configureUser()
    }
    
    private func configureGetInTouchImage() {
        view.addSubview(getInTouchImage)
        
        getInTouchImage.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(300)
        }
    }
    
    private func configureHeadText() {
        view.addSubview(headLabel)
        view.addSubview(descriptionLabel)
        
        headLabel.text = "Get In Touch"
        descriptionLabel.text = "If you have any inquiries get in touch with us. We'll be happy to help you"
        
        headLabel.snp.makeConstraints { make in
            make.top.equalTo(getInTouchImage.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        
        descriptionLabel.numberOfLines = 2
        descriptionLabel.textAlignment = .center
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(headLabel.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(20)
        }
    }
    
    private func configureUser() {
        view.addSubview(user)
        
        user.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(50)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.height.equalTo(100)
        }
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                          action: #selector(sendEmail))
        user.sendImage.isUserInteractionEnabled = true
        user.sendImage.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc private func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            mailComposer.mailComposeDelegate = self
            mailComposer.setToRecipients([user.userEmail!])
            present(mailComposer, animated: true)
        } else {
            presentAlert(title: "Error!",
                         message: "Email sending process could not be completed",
                         buttonTitle: "Ok")
        }
    }
}
