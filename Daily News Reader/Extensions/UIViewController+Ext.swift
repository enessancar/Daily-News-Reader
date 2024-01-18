//
//  UIViewController+Ext.swift
//  Daily News Reader
//
//  Created by Enes Sancar on 18.01.2024.
//

import UIKit

extension UIViewController {
    
    func presentAlert(title: String, message: String, buttonTitle: String) {
        let alertVC = AlertVC(title: title, message: message, buttonTitle: buttonTitle)
        alertVC.modalPresentationStyle = .overFullScreen
        alertVC.modalTransitionStyle = .crossDissolve
        self.present(alertVC, animated: true)
    }
}
