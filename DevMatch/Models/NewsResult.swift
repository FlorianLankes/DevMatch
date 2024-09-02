//
//  NewsResult.swift
//  DevMatch
//
//  Created by Florian Lankes on 25.07.24.
//

import Foundation

struct NewsResult: Codable {
    let articles: [Articel]
}

struct Articel: Codable {
    let source: Source
    let author: String
    let title: String?
    let description: String
    let urlToImage: URL?
    let content: String
    let publishedAt: String
    let url: String
    
    struct Source: Codable, Identifiable {
        let name: String
        //MARK: - Identifiable
        let id: String?
    }
    
}
