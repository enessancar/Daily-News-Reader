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
    
    private lazy var user = HelpAndSupportView(userEmail: "enes57@gmail.com")
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemBackground
        configureImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func configureImageView() {
        addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
        }
    }
}
