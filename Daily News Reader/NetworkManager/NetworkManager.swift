//
//  NewsService.swift
//  Daily News Reader
//
//  Created by Enes Sancar on 19.01.2024.
//

import Foundation

final class NetworkManager {
    static let shared = NetworkManager()
    let decoder = JSONDecoder()
    
    private init() {
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
    }
    
    func getNews() async throws -> [News] {
        let endpoint =  Constants.baseURL + Endpoint.topHeadlines + Constants.apiKey
        
        guard let url = URL(string: endpoint) else {
            throw CustomError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw CustomError.invalidResponse
        }
        
        do {
            let response = try decoder.decode(NewsModel.self, from: data)
            let filteredResponse = response.articles.filter({ $0.title != nil && $0.description != nil && $0.urlToImage != nil })
            return filteredResponse
        } catch {
            throw CustomError.invalidData
        }
    }
    
    // MARK: - Fetch News Category
    func getNewsCategory(category: String) async throws -> [News] {
        let endpoint =  Constants.baseURL + Endpoint.topHeadlines + Endpoint.category + "\(category)" + Constants.apiKey
        
        guard let url = URL(string: endpoint) else {
            throw CustomError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw CustomError.invalidResponse
        }
        
        do {
            let response = try decoder.decode(NewsModel.self, from: data)
            let filteredResponse = response.articles.filter({ $0.title != nil && $0.description != nil && $0.urlToImage != nil })
            return filteredResponse
        } catch {
            throw CustomError.invalidResponse 
        }
    }
    
    // MARK: - Fetch News Category
    func getNewsSearch(search: String) async throws -> [News] {
        let endpoint = Constants.baseURL + Endpoint.search + "\(search)" + Constants.apiKey
        
        guard let url = URL(string: endpoint) else {
            throw CustomError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw CustomError.invalidResponse
        }
        
        do {
            let response = try decoder.decode(NewsModel.self, from: data)
            let filteredResponse = response.articles.filter({ $0.title != nil && $0.description != nil && $0.urlToImage != nil })
            return filteredResponse
        } catch {
            throw CustomError.invalidData
        }
    }
}
