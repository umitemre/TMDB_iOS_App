//
//  MovieDetail.swift
//  TMDB Movie App
//
//  Created by Emre Aydin on 14.01.2023.
//

import Foundation

struct MovieDetail: Codable {
    let backdropPath: String?
    let id: Int?
    let overview: String?
    let releaseDate: String?
    let title: String?
    let imdbId: String?
    let voteAverage: Double?
    
    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case id
        case overview
        case releaseDate = "release_date"
        case title
        case imdbId = "imdb_id"
        case voteAverage = "vote_average"
    }
}
