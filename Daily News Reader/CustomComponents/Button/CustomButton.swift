//
//  CustomButton.swift
//  Daily News Reader
//
//  Created by Enes Sancar on 18.01.2024.
//

import UIKit

final class CustomButton: UIButton {
    
    enum FontSize {
        case big
        case medium
        case small
    }
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(bgColor: UIColor ,
                     color: UIColor,
                     title: String,
                     fontSize: FontSize = .medium,
                     systemImageName: String? = nil,
                     cornerStyle: UIButton.Configuration.CornerStyle? = .medium) {
        
        self.init(frame: .zero)
        
        set(bgColor: bgColor ,
            color: color,
            title: title,
            fontSize: fontSize,
            systemImageName: systemImageName,
            cornerStyle: cornerStyle)
    }
    
    private func configure() {
        configuration = .tinted()
        configuration?.cornerStyle = .medium
    }
    
    func set(bgColor: UIColor ,color: UIColor, title: String, fontSize: FontSize, systemImageName: String?,cornerStyle: UIButton.Configuration.CornerStyle?) {
        configuration?.baseBackgroundColor = bgColor
        configuration?.baseForegroundColor = color
        configuration?.cornerStyle = cornerStyle ?? .medium
        configuration?.title = title
        
        if let imageName = systemImageName {
            configuration?.image = UIImage(systemName: imageName)
            configuration?.imagePadding = 6
        }
        
        switch fontSize {
        case .big:
            self.titleLabel?.font = .systemFont(ofSize: 22, weight: .bold)
        case .medium:
            self.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        case .small:
            self.titleLabel?.font = .systemFont(ofSize: 16, weight: .regular)
        }
    }
}
