//
//  APIClient.swift
//  NewsTestApp
//
//  Created by Пазин Даниил on 18.02.2021.
//

import Foundation
import Combine

struct APIClient {
    private let queue = DispatchQueue(label: "APIClient", qos: .default, attributes: .concurrent)
    
    func headlinesByCountry(country: Method.NewsCountries) -> AnyPublisher<ParsingService.NewsAPIResult, ErrorNetwork> {
        return URLSession.shared
            .dataTaskPublisher(for: Method.topNews(country).url!)
            .receive(on: queue)
            .map(\.data)
            .tryMap({
                try ParsingService.NewsAPIResult.init(apiData: $0)
            })
            .mapError({ error -> ErrorNetwork in
                switch error {
                case is URLError:
                    return ErrorNetwork.unreachableAddress(url: Method.topNews(country).url!)
                default:
                    return ErrorNetwork.invalidResponse
                }
            })
            .eraseToAnyPublisher()
    }
}
