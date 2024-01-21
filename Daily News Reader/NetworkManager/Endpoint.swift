//
//  Endpoint.swift
//  Daily News Reader
//
//  Created by Enes Sancar on 19.01.2024.
//

import Foundation

struct Constants {
    private init() {}
    
    static let baseURL = "https://newsapi.org/v2/"
    static let apiKey  = "&apiKey=774527d9f9134f4fbb4032bec7f77007"
}

struct Endpoint {
    private init() {}
    
    static let topHeadlines = "top-headlines?country=us"
    static let category = "&category="
    static let search = "everything?q="
}
