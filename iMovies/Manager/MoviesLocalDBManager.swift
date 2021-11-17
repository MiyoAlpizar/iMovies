//
//  MoviesSQLiteManager.swift
//  iMovies
//
//  Created by Miyo on 14/11/21.
//

import RxSwift


///Fetches movies from local data base in order to keep alive offline
class MoviesLocalDBManager: MoviesManagerProtocol {
    let service = TheMovieDBService.shared
    
    func getHomeShows(type: ShowType) -> Observable<[Poster]> {
        return Observable.create { observer in
            switch type {
            case .movie:
                observer.onNext(self.getHomeMovies())
            case .serie:
                observer.onNext(self.getHomeSeries())
            }
            observer.onCompleted()
            return Disposables.create {
            }
        }
    }
    
    func getGenres(type: ShowType) -> Observable<[Genre]> {
        return Observable.create { observer in
            observer.onNext(self.getGener(type: type))
            observer.onCompleted()
            return Disposables.create {}
        }
    }
    
    func getShowsByCategory(type: ShowType, category: ShowCategory) -> Observable<[ShowInfo]> {
        return Observable.create { observer in
            switch type {
            case .movie:
                observer.onNext(self.getMovieByCategory(category: category))
            case .serie:
                observer.onNext(self.getSerieByCategory(category: category))
            }
            observer.onCompleted()
            return Disposables.create {}
        }
    }
    
    func getShowsByGenre(type: ShowType, id: Int) -> Observable<[ShowInfo]> {
        return Observable.create { observer in
            switch type {
            case .movie:
                observer.onNext(self.getMoviesByGenre(genreId: id))
            case .serie:
                observer.onNext(self.getSeriesByGenre(genreId: id))
            }
            observer.onCompleted()
            return Disposables.create {}
        }
    }
    
    func searchShows(type: ShowType, query: String) -> Observable<[ShowInfo]> {
        return Observable.create { observer in
            switch type {
            case .movie:
                observer.onNext(self.filterMovies(query: query.lowercased()))
            case .serie:
                observer.onNext(self.filterSeries(query: query.lowercased()))
            }
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
    
    func getSimilarShows(type: ShowType, id: Int) -> Observable<[ShowInfo]> {
        return Observable.create { observer in
            return Disposables.create{ }
        }
    }
}

extension MoviesLocalDBManager {
    
    private func getHomeMovies() -> [Poster] {
        var posters = [Poster]()
        
        let popular = getMovieByCategory(category: ShowCategory.popular)
        posters.append(Poster(category: ShowCategory.popular, posters: popular))
        
        let topRated = getMovieByCategory(category: ShowCategory.topRated)
        posters.append(Poster(category: ShowCategory.topRated, posters: topRated))
        
        let upcoming = getMovieByCategory(category: ShowCategory.upcoming)
        posters.append(Poster(category: ShowCategory.upcoming, posters: upcoming))
        
        let nowPlaying = getMovieByCategory(category: ShowCategory.nowPlaying)
        posters.append(Poster(category: ShowCategory.nowPlaying, posters: nowPlaying))
        
        return posters
        
    }
    
    private func getHomeSeries() -> [Poster] {
        var posters = [Poster]()
        
        let popular = getSerieByCategory(category: ShowCategory.popular)
        posters.append(Poster(category: ShowCategory.popular, posters: popular))
        
        let topRated = getSerieByCategory(category: ShowCategory.topRated)
        posters.append(Poster(category: ShowCategory.topRated, posters: topRated))
        
        let onTheAir = getSerieByCategory(category: ShowCategory.onTheAir)
        posters.append(Poster(category: ShowCategory.onTheAir, posters: onTheAir))
        
        let latest = getSerieByCategory(category: ShowCategory.latest)
        posters.append(Poster(category: ShowCategory.latest, posters: latest))
        
        return posters
        
    }
    
    private func getMovieByCategory(category: ShowCategory) -> [ShowInfo] {
        var shows = [ShowInfo]()
        let categoryMovies = RealmService.shared.realm.objects(CategoryMovies.self).filter("category == '\(category.rawValue)'").first
        if let categoryMovies = categoryMovies {
            let ids = Array(categoryMovies.idMovies.map({ Int($0) }))
            let movies = RealmService.shared.realm.objects(Movie.self).filter("id IN %@ AND backdropPath != nil AND posterPath != nil", ids)
            shows.append(contentsOf: movies.map({ $0.toShowInfo() }))
        }
        return shows
    }
    
    private func getSerieByCategory(category: ShowCategory) -> [ShowInfo] {
        var shows = [ShowInfo]()
        let categorySeries = RealmService.shared.realm.objects(CategorySeries.self).filter("category == '\(category.rawValue)'").first
        if let categoryMobies = categorySeries {
            let ids = Array(categoryMobies.idSeries.map({ Int($0) }))
            let series = RealmService.shared.realm.objects(Serie.self).filter("id IN %@ AND backdropPath != nil AND posterPath != nil", ids)
            shows.append(contentsOf: series.map({ $0.toShowInfo() }))
        }
        return shows
    }
    
    private func getGener(type: ShowType) -> [Genre] {
        var geners = [Genre]()
        
        switch type {
        case .movie:
            let movie = RealmService.shared.realm.objects(GenerMovies.self).filter("showType == '\(type.rawValue)'").first
            if let movie = movie {
                let ids = Array(movie.idGeners.map({Int($0)}))
                geners = Array(RealmService.shared.realm.objects(Genre.self).filter("id IN %@", ids))
            }
        case .serie:
            let serie = RealmService.shared.realm.objects(GenerSeries.self).filter("showType == '\(type.rawValue)'").first
            if let serie = serie {
                let ids = Array(serie.idGeners.map({Int($0)}))
                geners = Array(RealmService.shared.realm.objects(Genre.self).filter("id IN %@", ids))
            }
        }
        return geners
    }
    
    private func getMoviesByGenre(genreId: Int) -> [ShowInfo] {
        var shows = [ShowInfo]()
        let genres = RealmService.shared.realm.objects(MoviesGenre.self).filter("genreId == \(genreId)")
        let moviesIds = Array(genres.map({ Int($0.movieId) }))
        let movies = RealmService.shared.realm.objects(Movie.self).filter("id IN %@ AND backdropPath != nil AND posterPath != nil", moviesIds)
        shows.append(contentsOf: movies.map({ $0.toShowInfo() }))
        return shows
    }
    
    private func getSeriesByGenre(genreId: Int) -> [ShowInfo] {
        var shows = [ShowInfo]()
        let genres = RealmService.shared.realm.objects(SeriesGenre.self).filter("genreId == \(genreId)")
        let seriesIds = Array(genres.map({ Int($0.serieId) }))
        let series = RealmService.shared.realm.objects(Serie.self).filter("id IN %@ AND backdropPath != nil AND posterPath != nil", seriesIds)
        for item in series {
            shows.append(item.toShowInfo())
        }
        return shows
    }
    
    private func filterMovies(query: String) -> [ShowInfo] {
        var shows = [ShowInfo]()
        let movies = RealmService.shared.realm.objects(Movie.self).filter { movie in
            return movie.title.lowercased().contains(query) && movie.backdropURL != nil && movie.posterPath != nil
        }
        shows.append(contentsOf: movies.map({ $0.toShowInfo() }))
        return shows
    }
    
    private func filterSeries(query: String) -> [ShowInfo] {
        var shows = [ShowInfo]()
        let series = RealmService.shared.realm.objects(Serie.self).filter { serie in
            return serie.name.lowercased().contains(query) && serie.backdropURL != nil && serie.posterPath != nil
        }
        shows.append(contentsOf: series.map({ $0.toShowInfo() }))
        return shows
    }
}
