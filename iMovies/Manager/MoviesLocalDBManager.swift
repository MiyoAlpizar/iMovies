//
//  MoviesSQLiteManager.swift
//  iMovies
//
//  Created by Miyo on 14/11/21.
//

import RxSwift


///Fetches movies from local data base in order to keep alive offline
class MoviesLocalDBManager: MoviesManagerProtocol {
    
    func getHomeMovies() -> Observable<[HomeMovies]> {
        return Observable.create { observer in
            observer.onNext([])
            observer.onCompleted()
            return Disposables.create {}
        }
    }
    
    func getMovieVideos(id: Int) -> Observable<[MovieVideo]> {
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
}
