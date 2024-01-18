//
//  UIView+Ext.swift
//  Daily News Reader
//
//  Created by Enes Sancar on 18.01.2024.
//

import UIKit

extension UIView {
    
    func addSubviewsExt(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
}
