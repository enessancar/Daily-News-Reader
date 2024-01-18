//
//  AlertContainerView.swift
//  Daily News Reader
//
//  Created by Enes Sancar on 18.01.2024.
//

import UIKit

final class AlertContainerView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func configure() {
       backgroundColor     = .systemBackground
       layer.cornerRadius  = 16
       layer.borderWidth   = 2
       layer.borderColor   = UIColor.white.cgColor
    }
}
