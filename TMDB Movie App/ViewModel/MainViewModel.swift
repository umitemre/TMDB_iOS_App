//
//  MainViewModel.swift
//  TMDB Movie App
//
//  Created by Emre Aydin on 14.01.2023.
//

import Foundation
import RxSwift
import RxDataSources

class MainViewModel {
    let useCase = MainPageUseCase()

    private var _upcomingMovies = PublishSubject<[MovieResult]>()
    var upcomingMovies: Observable<[MovieResult]> {
        get {
            return _upcomingMovies
        }
    }

    func getUpcomingMovies() {
        self.useCase.fetchUpcomingMovies { data in
            guard let response = data.value,
                  let result = response.results else {
                
                if let error = data.error {
                    self._upcomingMovies.onError(error)
                    return
                }
                
                self._upcomingMovies.onError(NSError())
                return
            }

            self._upcomingMovies.onNext(result)
        }
    }
}
