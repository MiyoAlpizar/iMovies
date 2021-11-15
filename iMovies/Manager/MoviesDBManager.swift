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
    
    
    let service = TheMovieDBService.shared
    
    func getHomePosters(type: ShowType) -> Observable<[Poster]> {
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
    
    func getVideos(type: ShowType,id: Int) -> Observable<[MovieVideo]> {
        return Observable.create { observer in
            var moviewVides = [MovieVideo]()
            self.service.fetchVideos(id: id, type: type) { result in
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
    
    func getGenres(type: ShowType) -> Observable<[Genre]> {
        return Observable.create { observer in
            self.service.fetchGenres(type: type) { result in
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
    
    func getShowsByGenre(type: ShowType, id: Int) -> Observable<[ShowInfo]> {
        return Observable.create { observer in
            switch type {
            case .movie:
                self.getMoviesByGenre(id: id) { shows in
                    observer.onNext(shows)
                    observer.onCompleted()
                }
            case .serie:
                self.getSeriesByGenre(id: id) { shows in
                    observer.onNext(shows)
                    observer.onCompleted()
                }
            }
            return Disposables.create {}
        }
    }
    
    func getMoviesByCategory(catgeory: ShowCategory) -> Observable<[Movie]> {
        return Observable.create { observer in
            self.service.fetchMovies(category: catgeory) { result in
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
            self.service.searchMovies(query: text) { result in
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
            self.service.fetchSeriesByGener(id: id) { result in
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
    
    func getSeriesByCategory(catgeory: ShowCategory) -> Observable<[Serie]> {
        return Observable.create { observer in
            self.service.fetchSeries(category: catgeory) { result in
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
            self.service.searchSeries(query: text) { result in
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
    
    func getShowsByCategory(type: ShowType, category: ShowCategory) -> Observable<[ShowInfo]> {
        return Observable.create { observer in
            
            switch type {
            case .movie:
                self.getMovieByCategory(category: category) { movies in
                    observer.onNext(self.castMoviesToShowInfo(movies: movies))
                    observer.onCompleted()
                }
            case .serie:
                self.getSerieByCategory(category: category) { series in
                    observer.onNext(self.castSeriesToShowInfo(series: series))
                    observer.onCompleted()
                }
            }
            
            return Disposables.create {
                
            }
        }
    }
    
}


//MARK:- API Calls
extension MoviesDBManager {
    
    private func getHomeMovies(completion: @escaping(_ posters:[Poster]) -> ()) {
        var posters = [Poster]()
        getMovieByCategory(category: ShowCategory.popular) { popular in
            posters.append(Poster(category: ShowCategory.popular, posters: self.castMoviesToShowInfo(movies: popular)))
            self.getMovieByCategory(category: ShowCategory.topRated) { topRated in
                posters.append(Poster(category: ShowCategory.topRated, posters: self.castMoviesToShowInfo(movies: topRated)))
                self.getMovieByCategory(category: ShowCategory.upcoming) { upcoming in
                    posters.append(Poster(category: ShowCategory.upcoming, posters: self.castMoviesToShowInfo(movies: upcoming)))
                    self.getMovieByCategory(category: ShowCategory.nowPlaying) { nowPlaying in
                        posters.append(Poster(category: ShowCategory.nowPlaying, posters: self.castMoviesToShowInfo(movies: nowPlaying)))
                        completion(posters)
                    }
                }
            }
        }
    }
    
    private func getMovieByCategory(category: ShowCategory, completion: @escaping(_ movies: [Movie]) -> ()) {
        self.service.fetchMovies(category: category) { result in
            switch result {
            case .success(let movie):
                completion(movie.results)
            case .failure:
                completion([])
            }
        }
    }
    
    private func getHomeSeries(completion: @escaping(_ posters:[Poster]) -> ()) {
        var posters = [Poster]()
        getSerieByCategory(category: ShowCategory.popular) { series in
            posters.append(Poster(category: ShowCategory.popular, posters: self.castSeriesToShowInfo(series: series)))
            self.getSerieByCategory(category: ShowCategory.topRated) { series in
                posters.append(Poster(category: ShowCategory.topRated, posters: self.castSeriesToShowInfo(series: series)))
                self.getSerieByCategory(category: ShowCategory.onTheAir) { series in
                    posters.append(Poster(category: ShowCategory.onTheAir, posters: self.castSeriesToShowInfo(series: series)))
                    self.getSerieByCategory(category: ShowCategory.latest) { series in
                        posters.append(Poster(category: ShowCategory.latest, posters: self.castSeriesToShowInfo(series: series)))
                        completion(posters)
                    }
                }
            }
        }
    }
    
    private func getSerieByCategory(category: ShowCategory, completion: @escaping(_ series: [Serie]) -> ()) {
        self.service.fetchSeries(category: category) { result in
            switch result {
            case .success(let serie):
                completion(serie.results)
            case .failure:
                completion([])
            }
        }
    }
    
    private func getSeries(category: ShowCategory, completion: @escaping(_ movies: [Serie]) -> ()) {
        service.fetchSeries(category: category) { result in
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
    
    private func getMovies(category: ShowCategory, completion: @escaping(_ movies: [Movie]) -> ()) {
        service.fetchMovies(category: category) { result in
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
    
    private func getMoviesByGenre(id: Int, completion: @escaping([ShowInfo]) -> ()) {
        self.service.fetchMovieByGener(id: id) { result in
            switch result {
            case .success(let response):
                completion(self.castMoviesToShowInfo(movies: response.results))
            case .failure:
                completion([])
            }
        }
    }
    
    private func getSeriesByGenre(id: Int, completion: @escaping([ShowInfo]) -> ()) {
        self.service.fetchSeriesByGener(id: id) { result in
            switch result {
            case .success(let response):
                completion(self.castSeriesToShowInfo(series: response.results))
            case .failure:
                completion([])
            }
        }
    }
    
}


//MARK:- CASTS
extension MoviesDBManager {
    
    func castMoviesToShowInfo(movies: [Movie]) -> [ShowInfo]{
        var showsInfo = [ShowInfo]()
        for item in movies {
            if (item.posterPath != nil && item.backdropPath != nil) {
                showsInfo.append(item.toShowInfo())
            }
        }
        return showsInfo
    }
    
    func castSeriesToShowInfo(series: [Serie]) -> [ShowInfo] {
        var showsInfo = [ShowInfo]()
        for item in series {
            if (item.posterPath != nil && item.backdropPath != nil) {
                showsInfo.append(item.toShowInfo())
            }
        }
        return showsInfo
    }
}


