//
//  SupportView.swift
//  Daily News Reader
//
//  Created by Enes Sancar on 20.01.2024.
//

import UIKit
import SnapKit

final class SupportView: UIView {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = .getInTouch
        return imageView
    }()
    
    private lazy var headLabel = TitleLabel(textAlignment: .center, fontSize: 25)
    private lazy var descriptionLabel = SecondaryTitleLabel(fontSize: 20)
    
    private lazy var userView = HelpAndSupportView(userEmail: "enes57@gmail.com")
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        
        configureImageView()
        configureHeadText()
        configureUserView()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func configureImageView() {
        addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(250)
        }
    }
    
    private func configureHeadText() {
        addSubviews(headLabel, descriptionLabel)
        
        headLabel.text = "Get In Touch"
        descriptionLabel.text = "If you have any inquiries get in touch with us. We'll be happy to help you"
        
        headLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }
        
        descriptionLabel.numberOfLines = 2
        descriptionLabel.textAlignment = .center
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(headLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
    }
    
    private func configureUserView() {
        addSubview(userView)
        
        userView.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(100)
            make.centerX.equalToSuperview()
        }
    }
}
