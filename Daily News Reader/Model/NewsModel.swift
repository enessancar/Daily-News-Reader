//
//  NewsModel.swift
//  Daily News Reader
//
//  Created by Enes Sancar on 18.01.2024.
//

import Foundation

struct NewsModel: Codable {
    let articles: [News]
}

struct News: Codable {
    let source: Source?
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: Date?
    let content: String?  
    
    var _title: String {
        title ?? "N/A"
    }
    
    var _description: String {
        description ?? "N/A"
    }
    
    var _urlToImage: String {
        urlToImage ?? "N/A"
    }
    
    var _publishedAt: Date {
        publishedAt ?? .now
    }
}

struct Source: Codable {
    let id: String?
    let name: String?
}
