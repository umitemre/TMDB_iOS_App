//
//  ApiResponse.swift
//  TMDB Movie App
//
//  Created by Emre Aydin on 14.01.2023.
//

import Foundation

struct ApiResponse: Codable {
    let dates: Dates?
    let page: Int?
    let results: [MovieResult]?
    let totalPages: Int?
    let totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case dates
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
