//
//  SearchViewModel.swift
//  Daily News Reader
//
//  Created by Enes Sancar on 20.01.2024.
//

import Foundation

protocol ISearchViewModel {
    func getNewsSearch(searchTextt: String)
    func getNewsTopHeadLines()
    var  searchOutPut: SearchOutPut? { get }
    func setDelegate(output: SearchOutPut)
    var NewsData: [News] { get set }
}

// MARK: - Search View Model
class SearchVM :ISearchViewModel {
    var searchOutPut: SearchOutPut?
    var NewsData: [News] = []
    
    // MARK: - Set Delegate
    func setDelegate(output: SearchOutPut){
        searchOutPut = output
    }
    
    // MARK: - Get Top Headlines
    func getNewsTopHeadLines() {
        Task{
            do {
                let response = try await NetworkManager.shared.getNews()
                self.searchOutPut?.saveDatas(value: response)
            } catch {
                if let newsError = error as? CustomError {
                    print("Error fetch" + newsError.rawValue)
                }else {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    // MARK: - Search for News
    func getNewsSearch(searchTextt: String) {
        Task{
            do {
                let response = try await NetworkManager.shared.getNewsSearch(search: searchTextt)
                self.searchOutPut?.saveDatas(value: response)
            } catch {
                if let newsError = error as? CustomError {
                    print("Error fetch" + newsError.rawValue)
                } else {
                    print(error.localizedDescription)
                }
            }
        }
    }
}
