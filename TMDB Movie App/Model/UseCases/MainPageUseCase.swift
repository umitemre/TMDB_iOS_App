//
//  MainPageUseCase.swift
//  TMDB Movie App
//
//  Created by Emre Aydin on 15.01.2023.
//

class MainPageUseCase {
    let repository = MainPageRepository()
    
    func fetchUpcomingMovies(completion: @escaping (Result<ApiResponse, Error>) -> Void) {
        repository.fetchUpcomingMovies(completion: completion)
    }
    
    func fetchNowPlaying(completion: @escaping (Result<ApiResponse, Error>) -> Void) {
        repository.fetchNowPlaying(completion: completion)
    }
}
