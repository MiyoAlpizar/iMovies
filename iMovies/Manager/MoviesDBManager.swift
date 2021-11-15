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
    
    func getHomePosters(type: showType) -> Observable<[Poster]> {
        return Observable.create { observer in
            switch type {
            case .movie:
                self.getHomeMovies { posters in
                    observer.onNext(posters)
                    observer.onCompleted()
                }
            case .serie:
                self.getHomeSeries { posters in
                    observer.onNext(posters)
                    observer.onCompleted()
                }
            }
            return Disposables.create {
            }
        }
    }
    
    
   
    
    func getVideos(type: showType,id: Int) -> Observable<[MovieVideo]> {
        return Observable.create { observer in
            var moviewVides = [MovieVideo]()
            self.getVideos(type: type, id: id) { result in
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
    
    
    
    func getSeriesByGenre(id: Int) -> Observable<[Serie]> {
        return Observable.create { observer in
            TheMovieDBService.shared.fetchSeriesByGener(id: id) { result in
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
    
    func getSeriesByCategory(catgeory: MovieCategory) -> Observable<[Serie]> {
        return Observable.create { observer in
            TheMovieDBService.shared.fetchSeries(category: catgeory) { result in
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
    
    func filterSeries(text: String) -> Observable<[Serie]> {
        return Observable.create { observer in
            TheMovieDBService.shared.seacrhSeries(query: text) { result in
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

extension MoviesDBManager {
    
    private func getVideos(type: showType, id: Int, completion:@escaping(Result<MovieVideoResult, MovieError>) -> ()) {
        guard let url = URL(string: "\(APIService.shared.baseAPIURL)/\(type.rawValue)/\(id)/videos") else {
            return
        }
        APIService.shared.loadURLAndDecode(url: url, completion: completion)
    }
    
    private func getHomeMovies(completion: @escaping(_ posters:[Poster]) -> ()) {
        var posters = [Poster]()
        getMovieByCategory(category: MovieCategory.popular) { popular in
            posters.append(Poster(category: MovieCategory.popular, posters: self.castMoviesToShowInfo(movies: popular)))
            self.getMovieByCategory(category: MovieCategory.topRated) { topRated in
                posters.append(Poster(category: MovieCategory.topRated, posters: self.castMoviesToShowInfo(movies: topRated)))
                self.getMovieByCategory(category: MovieCategory.upcoming) { upcoming in
                    posters.append(Poster(category: MovieCategory.upcoming, posters: self.castMoviesToShowInfo(movies: upcoming)))
                    self.getMovieByCategory(category: MovieCategory.nowPlaying) { nowPlaying in
                        posters.append(Poster(category: MovieCategory.nowPlaying, posters: self.castMoviesToShowInfo(movies: nowPlaying)))
                        completion(posters)
                    }
                }
            }
        }
    }
    
    private func getMovieByCategory(category: MovieCategory, completion: @escaping(_ movies: [Movie]) -> ()) {
        getMoviesByCategory(category: category) { result in
            switch result {
            case .success(let movie):
                completion(movie.results)
            case .failure:
                completion([])
            }
        }
    }
    
    
    private func getMoviesByCategory(category: MovieCategory, completion: @escaping(Result<MovieResponse, MovieError>) -> ()) {
        guard let url = URL(string: "\(APIService.shared.baseAPIURL)/movie/\(category.rawValue)") else {
            return
        }
        APIService.shared.loadURLAndDecode(url: url, completion: completion)
        
    }
    
    private func getHomeSeries(completion: @escaping(_ posters:[Poster]) -> ()) {
        var posters = [Poster]()
        getSerieByCategory(category: MovieCategory.popular) { series in
            posters.append(Poster(category: MovieCategory.popular, posters: self.castSeriesToShowInfo(series: series)))
            self.getSerieByCategory(category: MovieCategory.topRated) { series in
                posters.append(Poster(category: MovieCategory.topRated, posters: self.castSeriesToShowInfo(series: series)))
                self.getSerieByCategory(category: MovieCategory.onTheAir) { series in
                    posters.append(Poster(category: MovieCategory.onTheAir, posters: self.castSeriesToShowInfo(series: series)))
                    self.getSerieByCategory(category: MovieCategory.latest) { series in
                        posters.append(Poster(category: MovieCategory.latest, posters: self.castSeriesToShowInfo(series: series)))
                        completion(posters)
                    }
                }
            }
        }
    }
    
    private func getSerieByCategory(category: MovieCategory, completion: @escaping(_ series: [Serie]) -> ()) {
        getSeriesByCategory(category: category) { result in
            switch result {
            case .success(let serie):
                completion(serie.results)
            case .failure:
                completion([])
            }
        }
    }
    
    
    private func getSeriesByCategory(category: MovieCategory, completion: @escaping(Result<SerieResults, MovieError>) -> ()) {
        guard let url = URL(string: "\(APIService.shared.baseAPIURL)/tv/\(category.rawValue)") else {
            return
        }
        APIService.shared.loadURLAndDecode(url: url, completion: completion)
    }
    
    
    private func getSeries(category: MovieCategory, completion: @escaping(_ movies: [Serie]) -> ()) {
        TheMovieDBService.shared.fetchSeries(category: category) { result in
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
}


