//
//  TitleLabel.swift
//  Daily News Reader
//
//  Created by Enes Sancar on 18.01.2024.
//

import UIKit

class TitleLabel: UILabel {
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(textAlignment: NSTextAlignment, fontSize: CGFloat, fontWeight: UIFont.Weight? = .bold) {
        self.init(frame: .zero)
        
        self.textAlignment = textAlignment
        self.font = .systemFont(ofSize: fontSize, weight: fontWeight!)
    }
    
    private func configure() {
        textColor  = .label
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.9
        lineBreakMode = .byTruncatingTail
    }
}

