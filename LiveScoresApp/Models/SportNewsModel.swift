//
//  SportNewsModel.swift
//  LiveScoresApp
//
//  Created by Donkemezuo Raymond Tariladou on 1/7/19.
//  Copyright © 2019 EnProTech Group. All rights reserved.
//

import Foundation

struct SportNews: Codable {
    var totalResults: Int
    var articles:[SportArticles]
}

struct SportArticles: Codable {
    var source: SourceInfo
    var author: String
    var title: String
    var description: String
    var url: String?
    var urlToImage:URL
    var publishedAt: String
    var content: String?
}

struct SourceInfo: Codable{
    var id: String
    var name: String
    
}
