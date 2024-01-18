//
//  BodyLabel.swift
//  Daily News Reader
//
//  Created by Enes Sancar on 18.01.2024.
//

import UIKit

class BodyLabel: UILabel {
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(textAlignment: NSTextAlignment) {
        self.init(frame: .zero)
        
        self.textAlignment = textAlignment
    }
    
    private func configure() {
        textColor  = .secondaryLabel
        font = .preferredFont(forTextStyle: .body)
        adjustsFontForContentSizeCategory = true
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.75
        lineBreakMode = .byWordWrapping
    }
}
