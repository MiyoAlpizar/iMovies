//
//  MoviesSQLiteManager.swift
//  iMovies
//
//  Created by Miyo on 14/11/21.
//

import RxSwift


///Fetches movies from local data base in order to keep alive offline
class MoviesLocalDBManager: MoviesManagerProtocol {
    func getShowsByCategory(type: ShowType, category: ShowCategory) -> Observable<[ShowInfo]> {
        return Observable.create { observer in
            observer.onNext([])
            observer.onCompleted()
            return Disposables.create {}
        }
    }
    
    func getShowsByGenre(type: ShowType, id: Int) -> Observable<[ShowInfo]> {
        return Observable.create { observer in
            observer.onNext([])
            observer.onCompleted()
            return Disposables.create {}
        }
    }
    
    func searchShows(type: ShowType, query: String) -> Observable<[ShowInfo]> {
        return Observable.create { observer in
            observer.onNext([])
            observer.onCompleted()
            return Disposables.create {}
        }
    }
    
    func getVideos(type: ShowType, id: Int) -> Observable<[MovieVideo]> {
        return Observable.create { observer in
            observer.onNext([])
            observer.onCompleted()
            return Disposables.create {}
        }
    }
    
    func getHomeShows(type: ShowType) -> Observable<[Poster]> {
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
    
    
    func getGenres(type: ShowType) -> Observable<[Genre]> {
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
    
    func getMoviesByCategory(catgeory: ShowCategory) -> Observable<[Movie]> {
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
    
    func getSeriesByCategory(catgeory: ShowCategory) -> Observable<[Serie]> {
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
