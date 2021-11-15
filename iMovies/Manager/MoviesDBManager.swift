//
//  MoviesDBManager.swift
//  iMovies
//
//  Created by Miyo on 13/11/21.
//

import Foundation
import RxSwift

///Fetches movies from https://www.themoviedb.org
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
                        self.getMovies(category: MovieCategory.nowPlaying) { nowPlaying in
                            homeMovies.append(HomeMovies(category: .nowPlaying, movies: nowPlaying))
                            observer.onNext(homeMovies)
                            observer.onCompleted()
                        }
                    }
                }
            }
            return Disposables.create {}
        }
    }
    
    func getMovieVideos(id: Int) -> Observable<[MovieVideo]> {
        return Observable.create { observer in
            var moviewVides = [MovieVideo]()
            TheMovieDBService.shared.fetchMovieVideos(id: id) { result in
                switch result {
                case .success(let videos):
                    moviewVides = videos.results
                    observer.onNext(moviewVides)
                case .failure(let error):
                    observer.onError(error)
                }
                observer.onCompleted()
            }
            return Disposables.create {}
        }
    }
    
    
    private func getMovies(category: MovieCategory, completion: @escaping(_ movies: [Movie]) -> ()) {
        TheMovieDBService.shared.fetchMovies(category: category) { result in
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
    
    func getGenres() -> Observable<[Genre]> {
        return Observable.create { observer in
            TheMovieDBService.shared.fetchGenres { result in
                switch result {
                case .success(let response):
                    observer.onNext(response.genres)
                case .failure(let error):
                    observer.onError(error)
                }
                observer.onCompleted()
            }
            return Disposables.create {}
        }
    }
    
    func getMoviesByGenre(id: Int) -> Observable<[Movie]> {
        return Observable.create { observer in
            TheMovieDBService.shared.fetchMovieByGener(id: id) { result in
                switch result {
                case .success(let response):
                    observer.onNext(response.results)
                case .failure(let error):
                    observer.onError(error)
                }
                observer.onCompleted()
            }
            return Disposables.create {}
        }
    }
    
    func getMoviesByCategory(catgeory: MovieCategory) -> Observable<[Movie]> {
        return Observable.create { observer in
            TheMovieDBService.shared.fetchMovies(category: catgeory) { result in
                switch result {
                case .success(let response):
                    observer.onNext(response.results)
                case .failure(let error):
                    observer.onError(error)
                }
                observer.onCompleted()
            }
            return Disposables.create {}
        }
    }
    
    func filterMovies(text: String) -> Observable<[Movie]> {
        return Observable.create { observer in
            TheMovieDBService.shared.seacrhMovie(query: text) { result in
                switch result {
                case .success(let response):
                    observer.onNext(response.results)
                case .failure(let error):
                    observer.onError(error)
                }
                observer.onCompleted()
            }
            return Disposables.create {}
        }
    }
    
}
