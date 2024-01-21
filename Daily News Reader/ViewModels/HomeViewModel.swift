//
//  HomeViewModel.swift
//  Daily News Reader
//
//  Created by Enes Sancar on 20.01.2024.
//

import Foundation

final class HomeViewModel  {
    var delegate: HomeProtocol? = nil
    
    func getNewsCategory(category: String) {
        Task{
            do {
                let response  = try await NetworkManager.shared.getNewsCategory(category: category)
                self.delegate?.saveDatas(value: response)
            } catch {
                if let newsError = error as? CustomError {
                    print("Error fetch" + newsError.rawValue)
                } else {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func getNewsTopHeadLines() {
        Task{
            do {
                let response = try await NetworkManager.shared.getNews()
                self.delegate?.saveDatas(value: response)
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

