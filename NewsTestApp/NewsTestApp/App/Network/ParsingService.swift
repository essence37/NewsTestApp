//
//  ParsingService.swift
//  NewsTestApp
//
//  Created by Пазин Даниил on 18.02.2021.
//

import Foundation

// Так как в результате одного запроса могут возвращаться разные модели данных, целесообразно вынести парсинг из Publisher.
enum ParsingService {
    typealias NewsAPIResult = Result<News, ErrorHandling>
}

extension ParsingService.NewsAPIResult {
    init(apiData: Data) throws {
        let decoder = JSONDecoder()
        do {
            let response = try decoder.decode(News.self, from: apiData)
            self = .success(response)
        } catch {
            let error = try decoder.decode(ErrorHandling.self, from: apiData)
            self = .failure(error)
        }
    }
}
