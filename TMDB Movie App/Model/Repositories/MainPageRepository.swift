//
//  MainPageRepository.swift
//  TMDB Movie App
//
//  Created by Emre Aydin on 15.01.2023.
//

import Alamofire
import Result

class MainPageRepository {
    func fetchUpcomingMovies(completion: @escaping (Result<ApiResponse, Error>) -> Void) {
        NetworkLayer.shared
            .url("https://api.themoviedb.org/3/movie/upcoming")
            .makeRequest { (result: Result<ApiResponse, Error>) in
                completion(result)
            }
    }

    func fetchNowPlaying(completion: @escaping (Result<ApiResponse, Error>) -> Void) {
        NetworkLayer.shared
            .url("https://api.themoviedb.org/3/movie/now_playing")
            .makeRequest { (result: Result<ApiResponse, Error>) in
                completion(result)
            }
    }
}
