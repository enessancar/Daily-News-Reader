//
//  ProfileVC.swift
//  Daily News Reader
//
//  Created by Enes Sancar on 18.01.2024.
//

import UIKit
import SnapKit
import Kingfisher

final class ProfileVC: UIViewController, UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    
    //MARK: - Properties
    private let viewModel = ProfileViewModel()
    private lazy var topContentView = UIView()
    private lazy var imageView = UIImageView()
    private lazy var userName = TitleLabel(textAlignment: .center, fontSize: 15)
    private lazy var segLabel = TitleLabel(textAlignment: .center, fontSize: 15)
   
    private let customTableVC = CustomTableVC()
   
    //MARK: - Init
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Profile", style: .plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem?.tintColor = .purple2
        
        configureTopContent()
        configureImageView()
        configureUserName()
        configureTableView()
    }
    
    private func configureTopContent() {
        view.addSubview(topContentView)
        
        topContentView.addSubview(imageView)
        topContentView.addSubview(userName)
        
        topContentView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(8)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(250)
        }
    }
    
    private func configureImageView() {
        imageView.image = UIImage(systemName: "person.crop.circle.badge.plus")
        
        imageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooeseImage))
        imageView.addGestureRecognizer(gestureRecognizer)
        
        imageView.layer.cornerRadius = 45
        imageView.clipsToBounds = true
        
        imageView.snp.makeConstraints { make in
            make.width.height.equalTo(90)
            make.center.equalToSuperview()
        }
        
        viewModel.fetchUserPhoto { image in
            self.imageView.kf.setImage(with: image.asUrl)
        }
    }
    
    private func configureUserName() {
        userName.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        viewModel.fetchUserName { userName in
            self.userName.text = userName
        }
    }
 
    @objc private func chooeseImage() {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        viewModel.uploadUserPhoto(imageData: imageView.image!)
        self.dismiss(animated: true)
    }
    
    private func configureTableView(){
        addChild(customTableVC)
        view.addSubview(customTableVC.view)
        customTableVC.didMove(toParent: self)
        
        let customWidth = customTableVC.view.frame.size.width
        let customHeight = customTableVC.view.frame.size.height
        
        customTableVC.view.snp.makeConstraints { make in
            make.top.equalTo(topContentView.snp.bottom).offset(8)
            make.width.equalTo(customWidth)
            make.height.equalTo(customHeight)
        }
    }
}
