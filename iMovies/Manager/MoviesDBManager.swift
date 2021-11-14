//
//  MoviesDBManager.swift
//  iMovies
//
//  Created by Miyo on 13/11/21.
//

import Foundation
import RxSwift

class MoviesDBManager: MoviesManagerProtocol {
    func getHomeMovies() -> Observable<[HomeMovies]> {
        return Observable.create { observer in
            var homeMovies = [HomeMovies]()
            self.getMovies(category: MovieCategory.popular) { popular in
                homeMovies.append(HomeMovies(category: .popular, movies: popular))
                self.getMovies(category: MovieCategory.topRated) { topRated in
                    homeMovies.append(HomeMovies(category: MovieCategory.topRated, movies: topRated))
                    self.getMovies(category: MovieCategory.upcoming) { upcoming in
                        homeMovies.append(HomeMovies(category: .upcoming, movies: upcoming))
                        observer.onNext(homeMovies)
                        observer.onCompleted()
                    }
                }
            }
            return Disposables.create {}
        }
        
    }
    
    private func getMovies(category: MovieCategory, completion: @escaping(_ movies: [Movie]) -> ()) {
        TheMovieDBService.shared.fetchMovies(category: MovieCategory.popular) { result in
            switch result {
            case .success(let response):
                if response.results.count > 0 {
                    completion(response.results)
                }else {
                    completion([])
                }
            case .failure(let error):
                print("Error on fetching movies: \(error.localizedDescription)")
                completion([])
            }
        }
    }
}