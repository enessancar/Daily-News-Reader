//
//  SecondaryTitleLabel.swift
//  Daily News Reader
//
//  Created by Enes Sancar on 18.01.2024.
//

import UIKit

class SecondaryTitleLabel: UILabel {
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(fontSize: CGFloat) {
        self.init(frame: .zero)
        font = .systemFont(ofSize: fontSize, weight: .medium)
    }
    
    // MARK: - Configuration
    private func configure() {
        textColor = .secondaryLabel
        adjustsFontForContentSizeCategory = true
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.90
        lineBreakMode = .byTruncatingTail
    }
}
