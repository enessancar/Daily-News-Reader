//
//  NewsModel.swift
//  Daily News Reader
//
//  Created by Enes Sancar on 18.01.2024.
//

import Foundation

struct NewsModel: Decodable {
    let articles: [News]
}

struct News: Decodable {
    let title: String?
    let description: String?
    let urlToImage: String?
    let publishedAt: String?
    let source: Source?
    let url: String?
    
    var _url: String {
        url ?? "N/A"
    }
    
    var _title: String {
        title ?? "N/A"
    }
    
    var _description: String {
        description ?? "N/A"
    }
    
    var _urlToImage: String {
        urlToImage ?? "N/A"
    }
    
    var _publishedAt: String {
        publishedAt ?? "N/A"
    }
}

struct Source: Decodable {
    let name: String?
    
    var _name: String {
        name ?? "N/A"
    }
}
