//
//  News.swift
//  NewsTestApp
//
//  Created by Пазин Даниил on 17.02.2021.
//

import Foundation

struct News: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}
