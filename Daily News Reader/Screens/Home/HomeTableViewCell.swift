//
//  HomeTableViewCell.swift
//  Daily News Reader
//
//  Created by Enes Sancar on 20.01.2024.
//

import UIKit
import SnapKit

final class HomeTableViewCell: UITableViewCell {
    static let identifier = "HomeTableViewCell"
    
    var news : News? = nil
    
    //MARK: - Properties
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .secondarySystemBackground
        view.layer.cornerRadius = 20
        view.layer.shadowColor = UIColor.label.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowOpacity = 0.7
        view.layer.shadowRadius = 4
        view.layer.masksToBounds = false
        return view
    }()
    
    lazy var newsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.maskedCorners = [
            .layerMinXMinYCorner,
            .layerMinXMaxYCorner
        ]
        imageView.layer.cornerRadius = 20
        return imageView
    }()
    
    lazy var timeSincePostLabel: UILabel = {
        let label = TitleLabel(textAlignment: .natural, fontSize: 12)
        label.textColor = .secondaryLabel
        label.text = "1 min ago"
        return label
    }()
    
    lazy var titleLabel: UILabel = {
        let label = TitleLabel(textAlignment: .natural, fontSize: 16)
        label.textColor = .label
        
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 3
        return label
    }()
    
    
    //MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        configureContainerView()
        configureImageView()
        configureLabels()
    }
    
    private func configureContainerView() {
        contentView.addSubview(containerView)
        
        containerView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(10)
            make.trailing.bottom.equalToSuperview().offset(-10)
        }
    }
    
    private func configureImageView() {
        containerView.addSubview(newsImageView)
        
        newsImageView.snp.makeConstraints { make in
            make.top.equalTo(containerView.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(containerView.safeAreaLayoutGuide.snp.leading)
            make.bottom.equalTo(containerView.safeAreaLayoutGuide.snp.bottom)
            make.width.height.equalTo(120)
        }
    }
    
    private func configureLabels() {
        containerView.addSubviews(titleLabel, timeSincePostLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.top).offset(10)
            make.leading.equalTo(newsImageView.snp.trailing).offset(10)
            make.trailing.equalTo(containerView.snp.trailing).offset(-10)
        }
        
        timeSincePostLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(titleLabel)
            make.bottom.equalTo(containerView.snp.bottom).offset(-10)
        }
    }
}
