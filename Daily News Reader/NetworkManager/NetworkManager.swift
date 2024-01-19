//
//  NewsService.swift
//  Daily News Reader
//
//  Created by Enes Sancar on 19.01.2024.
//

import Foundation

final class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    func getNews(completion: @escaping (Result<[News], CustomError>) -> ()) {
        let endpoint = Constants.baseURL + Endpoint.topHeadlines + Constants.apiKey
        guard let url = URL(string: endpoint) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let error else {
                completion(.failure(.unableToComplete))
                return
            }
            
            guard
                let response = response as? HTTPURLResponse,
                response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let response = try JSONDecoder().decode(NewsModel.self, from: data)
                let filteredResponse = response.articles.filter({ $0.title != nil && $0.description != nil && $0.urlToImage != nil })
                
                completion(.success(filteredResponse))
                
            } catch {
                completion(.failure(.unableToParseFromJSON))
            }
        }
        .resume()
    }
    
    func getNewsCategory(category: String, completion: @escaping(Result<[News], CustomError>) -> ()) {
        
        let endpoint =  Constants.baseURL + Endpoint.topHeadlines + Endpoint.category + "\(category)" + Constants.apiKey
        
        guard let url = URL(string: endpoint) else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let error else {
                completion(.failure(.unableToComplete))
                return
            }
            
            guard
                let response = response as? HTTPURLResponse,
                response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let response = try JSONDecoder().decode(NewsModel.self, from: data)
                let filteredResponse = response.articles.filter({ $0.title != nil && $0.description != nil && $0.urlToImage != nil })
                
                completion(.success(filteredResponse))
                
            } catch {
                completion(.failure(.unableToParseFromJSON))
            }
        }
        .resume()
    }
    
    func getNewsSearch(search: String, completion: @escaping(Result<[News], CustomError>) -> ()) {
        
        let endpoint = Constants.baseURL + Endpoint.search + "\(search)" + Constants.apiKey
        
        guard let url = URL(string: endpoint) else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let error else {
                completion(.failure(.unableToComplete))
                return
            }
            
            guard
                let response = response as? HTTPURLResponse,
                response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let response = try JSONDecoder().decode(NewsModel.self, from: data)
                let filteredResponse = response.articles.filter({ $0.title != nil && $0.description != nil && $0.urlToImage != nil })
                
                completion(.success(filteredResponse))
                
            } catch {
                completion(.failure(.unableToParseFromJSON))
            }
        }
        .resume()
    }
}
