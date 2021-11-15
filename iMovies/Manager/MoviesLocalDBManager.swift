//
//  MoviesSQLiteManager.swift
//  iMovies
//
//  Created by Miyo on 14/11/21.
//

import RxSwift


///Fetches movies from local data base in order to keep alive offline
class MoviesLocalDBManager: MoviesManagerProtocol {
    func getVideos(type: ShowType, id: Int) -> Observable<[MovieVideo]> {
        return Observable.create { observer in
            observer.onNext([])
            observer.onCompleted()
            return Disposables.create {}
        }
    }
    
    func getHomePosters(type: ShowType) -> Observable<[Poster]> {
        return Observable.create { observer in
            observer.onNext([])
            observer.onCompleted()
            return Disposables.create {}
        }
    }
    
    
    
    
    func getHomeMovies() -> Observable<[HomeMovies]> {
        return Observable.create { observer in
            observer.onNext([])
            observer.onCompleted()
            return Disposables.create {}
        }
    }
    
    
    func getGenres() -> Observable<[Genre]> {
        return Observable.create { observer in
            observer.onNext([])
            observer.onCompleted()
            return Disposables.create {}
        }
    }
    
    func getMoviesByGenre(id: Int) -> Observable<[Movie]> {
        return Observable.create { observer in
            print("Getting movies from local data base")
            observer.onNext([])
            observer.onCompleted()
            return Disposables.create {}
        }
    }
    
    func getMoviesByCategory(catgeory: MovieCategory) -> Observable<[Movie]> {
        return Observable.create { observer in
            observer.onNext([])
            observer.onCompleted()
            return Disposables.create {}
        }
    }
    
    func filterMovies(text: String) -> Observable<[Movie]> {
        return Observable.create { observer in
            observer.onNext([])
            observer.onCompleted()
            return Disposables.create {}
        }
    }
    
    func getVideos(id: Int) -> Observable<[MovieVideo]> {
        return Observable.create { observer in
            observer.onNext([])
            observer.onCompleted()
            return Disposables.create {}
        }
    }
    
    func getHomeSeries() -> Observable<[HomeSeries]> {
        return Observable.create { observer in
            observer.onNext([])
            observer.onCompleted()
            return Disposables.create {}
        }
    }
    
    func getSeriesByGenre(id: Int) -> Observable<[Serie]> {
        return Observable.create { observer in
            observer.onNext([])
            observer.onCompleted()
            return Disposables.create {}
        }
    }
    
    func getSeriesByCategory(catgeory: MovieCategory) -> Observable<[Serie]> {
        return Observable.create { observer in
            observer.onNext([])
            observer.onCompleted()
            return Disposables.create {}
        }
    }
    
    func filterSeries(text: String) -> Observable<[Serie]> {
        return Observable.create { observer in
            observer.onNext([])
            observer.onCompleted()
            return Disposables.create {}
        }
    }
    
    
}