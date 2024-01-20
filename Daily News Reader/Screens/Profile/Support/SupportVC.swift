//
//  SupportVC.swift
//  Daily News Reader
//
//  Created by Enes Sancar on 20.01.2024.
//

import UIKit
import SnapKit

final class SupportVC: UIViewController {
    
    private let supportView = SupportView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        view.addSubview(supportView)
        
        supportView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
