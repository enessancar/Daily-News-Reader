//
//  DetailVC.swift
//  Daily News Reader
//
//  Created by Enes Sancar on 20.01.2024.
//

import UIKit
import SnapKit
import Kingfisher

final class DetailVC: UIViewController {
    
    let news: News
    let viewModel: DetailViewModel
    lazy var isFavorited = false
    
    //MARK: - Properties
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 20
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var bookmarkButton: UIButton = {
        let rightBarBookmarkButton = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        rightBarBookmarkButton.layer.cornerRadius = 5
        rightBarBookmarkButton.tintColor = .purple1
        rightBarBookmarkButton.backgroundColor = .secondarySystemBackground
        rightBarBookmarkButton.addTarget(self, action: #selector(bookmarkButtonTapped), for: .touchUpInside)
        return rightBarBookmarkButton
    }()
    
    lazy var dateLabel: SecondaryTitleLabel = {
        let label = SecondaryTitleLabel(fontSize: 20)
        label.textColor = .label
        return label
    }()
    
    lazy var titleLabel: TitleLabel = {
        let label = TitleLabel(textAlignment: .left, fontSize: 25, fontWeight: .bold)
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        label.textColor = .purple1
        return label
    }()
    
    lazy var descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.isScrollEnabled = true
        textView.isEditable = false
        textView.isSelectable = false
        textView.font = UIFont.systemFont(ofSize: 22)
        return textView
    }()
    
    //MARK: - Initializers
    init(news: News) {
        self.news = news
        self.viewModel = DetailViewModel()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    //MARK: - Helper Functions
    func configureUI() {
        view.backgroundColor = .systemBackground
        configureNavigationBar()
        configureBookmarkButton()
        configureImageView()
        configureTitleLabel()
        configureDateLabel()
        configureDescriptonTextView()
    }
    
    func configureBookmarkButton() {
        viewModel.isFavorited(news: news) { bool in
            self.isFavorited = bool
            self.bookmarkButton.setImage(UIImage(systemName: bool ? "bookmark.fill" : "bookmark"), for: .normal)
        }
    }
    
    func configureNavigationBar() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor : UIColor.label]
        navBarAppearance.titleTextAttributes = [.foregroundColor : UIColor.label]
        navBarAppearance.backgroundColor = .systemBackground
        
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.compactAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = .label
        navigationItem.title = ""
        
        let rightBarButton = UIBarButtonItem(customView: bookmarkButton)
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    func configureImageView() {
        view.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(8)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(10)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-10)
            make.height.equalTo(300)
        }
        imageView.kf.setImage(with: news._urlToImage.asUrl)
    }
    
    func configureTitleLabel() {
        view.addSubview(titleLabel)
        titleLabel.textAlignment = .center
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
        titleLabel.text = news._title
    }
    
    func configureDateLabel() {
        view.addSubview(dateLabel)
        dateLabel.textColor = .secondaryLabel
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(12)
            make.leading.trailing.equalTo(titleLabel)
        }
        dateLabel.text = news._publishedAt.convertToMonthYearFormat()
    }
    
    func configureDescriptonTextView() {
        view.addSubview(descriptionTextView)
        
        descriptionTextView.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(12)
            make.leading.trailing.equalTo(titleLabel)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-10)
        }
        descriptionTextView.text = news._description
    }
    
    @objc func bookmarkButtonTapped() {
        if isFavorited {
            viewModel.removeFromFavorites(news: news) { bool in
                self.isFavorited = bool
                self.bookmarkButton.setImage(UIImage(systemName: "bookmark.circle"), for: .normal)
            }
        } else {
            viewModel.addToFavorites(news: news) { bool in
                self.isFavorited = bool
                self.bookmarkButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
            }
        }
    }
}
