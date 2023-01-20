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

    private var _mainPageMovieList = PublishSubject<[MainPageModel]>()
    var mainPageMovieList: Observable<[MainPageModel]> {
        get {
            return _mainPageMovieList
        }
    }
    
    var nowPlayingScrollState: CGPoint?

    func getMainPageMovieList() {
        let dispatchGroup = DispatchGroup()
        let mainPageModel = MainPageModel()

        dispatchGroup.enter()
        DispatchQueue.global().async {
            self.useCase.fetchUpcomingMovies { data in
                guard let response = data.value,
                      let result = response.results else {
                    
                    if let error = data.error {
                        mainPageModel.errors.append(error)
                        dispatchGroup.leave()
                        return
                    }

                    mainPageModel.errors.append(NSError())
                    dispatchGroup.leave()
                    return
                }
                
                mainPageModel.upcoming = result
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.enter()
        DispatchQueue.global().async {
            self.useCase.fetchNowPlaying { data in
                guard let response = data.value,
                      let result = response.results else {
                    
                    if let error = data.error {
                        mainPageModel.errors.append(error)
                        dispatchGroup.leave()
                        return
                    }

                    mainPageModel.errors.append(NSError())
                    dispatchGroup.leave()
                    return
                }
                
                mainPageModel.nowPlaying = result
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            if mainPageModel.errors.count > 0 {
                // TODO: Send empty error for now
                self._mainPageMovieList.onError(NSError())
                return
            }

            self._mainPageMovieList.onNext([mainPageModel])
        }
    }
}

class MainPageModel: SectionModelType {
    typealias Item = MovieResult

    var upcoming: [MovieResult]?
    var nowPlaying: [MovieResult]?
    var errors: [Error] = []

    var items: [MovieResult] {
        return upcoming ?? []
    }

    required init(original: MainPageModel, items: [MovieResult]) {
        self.upcoming = original.upcoming
        self.nowPlaying = original.nowPlaying
    }
    
    init() {
        
    }
}
