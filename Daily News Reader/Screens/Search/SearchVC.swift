//
//  SearchVC.swift
//  Daily News Reader
//
//  Created by Enes Sancar on 18.01.2024.
//

import UIKit
import SnapKit
import Kingfisher

protocol SearchOutPut {
    func saveDatas(value: [News])
}

final class SearchVC: UIViewController {
    
    // MARK: - UI Elements
    private let searchController = UISearchController(searchResultsController: nil)
    let tableView = UITableView()
    
    // MARK: - Properties
    private let viewModel: ISearchViewModel  = SearchVM()
    private lazy var news : [News] = []
    lazy var workItem = WorkItem()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Helper Functions
    private func configureUI() {
        view.backgroundColor = .systemBackground
        createSearchBar()
        configureTableView()
        
        viewModel.setDelegate(output: self)
        viewModel.getNewsTopHeadLines()
    }
    
    private func updateUI(news: [News]? = nil){
        self.news = news!
        tableView.reloadData()
    }
    
    // MARK: - TableView Configure
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
// MARK: - Network VM Protocol
extension SearchVC: SearchOutPut {
    func saveDatas(value: [News]) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.updateUI( news: value)
        }
    }
}

// MARK: - TableView
extension SearchVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        news.count
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
}

extension SearchVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let news = news[indexPath.row]
        
        navigationController?.pushViewController(DetailVC(news: news), animated: true)
    }
}

//MARK: - SearchBar Methods
extension SearchVC: UISearchBarDelegate {

    private func createSearchBar() {
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        workItem.perform(after: 0.5) {
            if !searchText.isEmpty {
                self.viewModel.getNewsSearch(searchTextt: searchText)
            } else {
                self.viewModel.getNewsTopHeadLines()
            }
        }
    }
}
