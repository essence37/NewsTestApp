//
//  ErrorHandling.swift
//  NewsTestApp
//
//  Created by Пазин Даниил on 17.02.2021.
//

import Foundation

struct ErrorHandling: Error, Codable {
    let status: String
    let code: String
    let message: String
}
