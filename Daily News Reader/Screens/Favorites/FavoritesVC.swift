//
//  FavoritesVC.swift
//  Daily News Reader
//
//  Created by Enes Sancar on 18.01.2024.
//

import UIKit
import SnapKit
import Kingfisher

final class FavoritesVC: UIViewController {
    //MARK: - Variables
    let viewModel: FavoritesViewModel
    var news: [News] = []
    
    //MARK: - UI Elements
    let tableView = UITableView()
    
    //MARK: - Initializers
    init() {
        self.viewModel = FavoritesViewModel()
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
    
    override func viewWillAppear(_ animated: Bool) {
        refreshUI()
    }
        
    //MARK: - Helper Functions
    private func refreshUI() {
        viewModel.fetchFavorites { news in
            self.news = news
            self.tableView.reloadData()
        }
    }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        title = "Favorites"
        configureTableView()
    }

    private func configureTableView() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        tableView.separatorStyle = .none
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: HomeTableViewCell.identifier)
    }
}

extension FavoritesVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as? HomeTableViewCell else {
            fatalError()
        }
        cell.selectionStyle = .none
        
        let news = news[indexPath.row]
        
        cell.titleLabel.text = news._title
        cell.newsImageView.kf.setImage(with: news._urlToImage.asUrl)
        cell.timeSincePostLabel.text = news._publishedAt.convertToMonthYearFormat()
        
        return cell
    }
    
     
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete"){
            (contextualAction, view, boolValue) in
            
            let news = self.news[indexPath.row]
            self.viewModel.removeFromFavorites(news: news)
            self.refreshUI()
            
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

extension FavoritesVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let news = news[indexPath.row]
        
        navigationController?.pushViewController(DetailVC(news: news), animated: true)
    }
}
