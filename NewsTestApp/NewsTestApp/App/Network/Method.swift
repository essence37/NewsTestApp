//
//  Method.swift
//  NewsTestApp
//
//  Created by Пазин Даниил on 17.02.2021.
//

import Foundation

// Перечисление методов API.
enum Method {
    enum NewsCountries: String {
        case russia = "ru"
        case usa = "us"
    }
    
    case topNews(NewsCountries)
    case bbcNews
    
    // Вычисляемое свойство, возвращающее полный URL для каждого метода.
    var url: URL? {
        switch self {
        case .topNews(let nation):
            var components = URLComponents(string: "http://newsapi.org/v2/top-headlines")
            let queryItemAPIkey = URLQueryItem(name: "apiKey", value: Session.instance.apiKey)
            let queryItemCountry = URLQueryItem(name: "country", value: nation.rawValue)
            components?.queryItems = [queryItemAPIkey, queryItemCountry]
            return components?.url
        case .bbcNews:
            var components = URLComponents(string: "http://newsapi.org/v2/top-headlines")
            let queryItemAPIkey = URLQueryItem(name: "apiKey", value: Session.instance.apiKey)
            let queryItemSources = URLQueryItem(name: "sources", value: "bbc-news&")
            components?.queryItems = [queryItemAPIkey, queryItemSources]
            return components?.url
        }
    }
}
