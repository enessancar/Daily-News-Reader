//
//  SwitchTableViewCell.swift
//  Daily News Reader
//
//  Created by Enes Sancar on 20.01.2024.
//

import UIKit
import SnapKit

final class SwitchTableViewCell: UITableViewCell {
    static let identifier = "SwitchTableViewCell"
    
    //MARK: - Properties
    private lazy var iconContainer: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        return view
    }()
    
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .purple1
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var mySwitch: UISwitch = {
        let mySwitch = UISwitch()
        mySwitch.onTintColor = .purple1
        return mySwitch
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(label)
        contentView.addSubview(iconContainer)
        contentView.addSubview(mySwitch)
        
        iconContainer.addSubview(iconImageView)
        
        contentView.clipsToBounds = true
        accessoryType = .disclosureIndicator
        
        mySwitch.addTarget(self, action: #selector(darkModeSwitchValueChanged(_:)), for: .valueChanged)
        
        configureUI()
        updateDarkModeUI()
    }
    
    @objc private func darkModeSwitchValueChanged(_ sender: UISwitch) {
        let isDarkModeOn = sender.isOn
        
        if isDarkModeOn {
            UserDefaults.standard.set(true, forKey: "DarkMode")
        } else {
            UserDefaults.standard.set(false, forKey: "DarkMode")
        }
        updateDarkModeUI()
        
        if #available(iOS 15.0, *) {
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                windowScene.windows.forEach { window in
                    window.overrideUserInterfaceStyle = isDarkModeOn ? .dark : .light
                }
            }
        } else {
            UIApplication.shared.windows.forEach { window in
                window.overrideUserInterfaceStyle = isDarkModeOn ? .dark : .light
            }
        }
    }
    
    private func updateDarkModeUI() {
        let isDarkModeOn = UserDefaults.standard.bool(forKey: "DarkMode")
        mySwitch.isOn = isDarkModeOn
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        mySwitch.sizeToFit()
        
        let mySwitchwidth: CGFloat = mySwitch.frame.size.width
        let mySwitchheight: CGFloat = mySwitch.frame.size.height
        
        let size: CGFloat = contentView.frame.size.height - 12
        let imageSize: CGFloat = size/1.5
        
        iconContainer.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(15)
            make.bottom.top.equalToSuperview()
            make.width.height.equalTo(size)
            make.centerY.equalToSuperview()
        }
        
        iconImageView.snp.makeConstraints { make in
            make.width.height.equalTo(imageSize)
            make.center.equalToSuperview()
        }
        
        label.snp.makeConstraints { make in
            make.leading.equalTo(iconContainer.snp.trailing).offset(20)
            make.top.bottom.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        mySwitch.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-20)
            make.centerY.equalToSuperview()
            make.width.equalTo(mySwitchwidth)
            make.height.equalTo(mySwitchheight)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconImageView.image = nil
        label.text = nil
        iconContainer.backgroundColor = nil
        mySwitch.isOn = false
    }
    
    public func configure(with model: SettingsSwitchOption){
        label.text = model.title
        iconImageView.image = model.icon
        iconContainer.backgroundColor = model.iconBackgrondColor
        mySwitch.isOn = model.isOn
    }
}
