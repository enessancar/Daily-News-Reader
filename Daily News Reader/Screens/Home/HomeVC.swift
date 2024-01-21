//
//  HomeVC.swift
//  Daily News Reader
//
//  Created by Enes Sancar on 18.01.2024.
//

import UIKit
import SnapKit
import Kingfisher

protocol HomeProtocol {
    func saveDatas(value: [News])
    func pushDetail(value: News)
}

final class HomeVC: UIViewController {
    
    private lazy var showNotificationsButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal.decrease")!,
                                     menu: addMenuItems())
        button.tintColor = .purple1
        return button
    }()
    
    private lazy var newsView: NewsView = {
        let newsView = NewsView()
        newsView.delegate = self
        return newsView
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: HomeTableViewCell.identifier)
        return tableView
    }()
    
    // MARK: Properties
    private lazy var viewModel: HomeViewModel = {
        let viewModel = HomeViewModel()
        viewModel.delegate = self
        return viewModel
    }()
    
    private lazy var newsArray: [News] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Daily News Reader"
        
        configureUI()
    }
    
    private func configureUI() {
        configureNewsView()
        configureTableView()
        viewModel.getNewsTopHeadLines()
        
        navigationItem.rightBarButtonItem = showNotificationsButton
    }
    
    private func updateUI(news: [News]? = nil){
        newsArray = news!
        newsView.news = news
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    private func configureNewsView() {
        view.addSubview(newsView)
        
        newsView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            make.height.equalTo(300)
        }
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(newsView.snp.bottom).offset(8)
            make.leading.trailing.equalTo(newsView)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    private func addMenuItems() -> UIMenu {
        return UIMenu(title: "Categories", options: .displayInline, children: [
            
            UIAction(title:"General", image: UIImage(systemName: "globe")) { _ in
                self.viewModel.getNewsCategory(category: "General")
            },
            
            UIAction(title:"Business", image: UIImage(systemName: "dollarsign")) { _ in
                self.viewModel.getNewsCategory(category: "Business")
            },
            
            UIAction(title:"Entertainment", image: UIImage(systemName: "gamecontroller")) { _ in
                self.viewModel.getNewsCategory(category: "Entertainment")
            },
            
            UIAction(title: "Health", image: UIImage(systemName: "cross.case")) { _ in
                self.viewModel.getNewsCategory(category: "Health")
            },
            
            UIAction(title:"Science", image: UIImage(systemName: "pill.circle")) { _ in
                self.viewModel.getNewsCategory(category: "Science")
            },
            
            UIAction(title:"Sports", image: UIImage(systemName: "baseball")) { _ in
                self.viewModel.getNewsCategory(category: "Sports")
            },
            
            UIAction(title:"Technology", image: UIImage(systemName: "laptopcomputer")) { _ in
                self.viewModel.getNewsCategory(category: "Technology")
            }
        ])
    }
}

extension HomeVC: HomeProtocol {
    func saveDatas(value: [News]) {
        DispatchQueue.main.async {
            self.updateUI(news: value)
            self.tableView.reloadData()
        }
    }
    
    func pushDetail(value: News) {
        navigationController?.pushViewController(DetailVC(news: value), animated: true)
    }
}

extension HomeVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        newsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as? HomeTableViewCell else {
            fatalError()
        }
        cell.selectionStyle = .none
        
        let news = newsArray[indexPath.row]
        
        cell.titleLabel.text = news._title
        cell.newsImageView.kf.setImage(with: news._urlToImage.asUrl)
        cell.timeSincePostLabel.text = news._publishedAt.convertToMonthYearFormat()
        return cell
    }
}

extension HomeVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let news = newsArray[indexPath.row]
        
        navigationController?.pushViewController(DetailVC(news: news), animated: true)
    }
}

