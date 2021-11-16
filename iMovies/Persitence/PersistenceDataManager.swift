//
//  PersistenceDataManager.swift
//  iMovies
//
//  Created by Miyo on 15/11/21.
//

import Foundation
import RealmSwift

class PersistenceDataManager {
    static let shared = PersistenceDataManager()
    private init() {}
    
    private let realmService = RealmService.shared
    
    func saveMoviesCategory(category: ShowCategory, movies: [Movie]) {
        
        //Add Or Update Movies
        realmService.AddOrUpdate(movies)
        saveGenreAndMovies(movies: movies)
        
        //Get the movies Ids
        let ids = movies.reduce([Int](), { $0 + [$1.id] })
        
        //Create new object to store movies ids with category
        let categoryMovies = CategoryMovies()
        
        categoryMovies.category = category.rawValue
        categoryMovies.idMovies = ids.toList()
        
        //Add or update category movies array
        realmService.AddOrUpdate(categoryMovies)
    }
    
    func saveSeriesCategory(category: ShowCategory, series: [Serie]) {
        
        //Add Or Update Series
        realmService.AddOrUpdate(series)
        saveGenreAndSeries(series: series)
        
        //Get the series Ids
        let ids = series.reduce([Int](), { $0 + [$1.id] })
        
        //Create new object to store series ids with category
        let categorySeries = CategorySeries()
        
        categorySeries.category = category.rawValue
        categorySeries.idSeries = ids.toList()
        
        //Add or update category series array
        realmService.AddOrUpdate(categorySeries)
        
        
        let _series = realmService.realm.objects(Serie.self)
        let _categories = realmService.realm.objects(CategorySeries.self)
        print("Hay \(_series.count) Series")
        print("Hay \(_categories.count) ShowCategories")
    }
    
    func saveGenres(showType: ShowType, genres: [Genre]) {
        realmService.AddOrUpdate(genres)
        
        //Get the genres Ids
        let ids = genres.reduce([Int](), { $0 + [$1.id] })
        
        switch showType {
        case .movie:
            let generMovies = GenerMovies()
            generMovies.idGeners = ids.toList()
            generMovies.showType = showType.rawValue
            realmService.AddOrUpdate(generMovies)
        case .serie:
            let generSeries = GenerSeries()
            generSeries.idGeners = ids.toList()
            generSeries.showType = showType.rawValue
            realmService.AddOrUpdate(generSeries)
        }
    }
    
    func saveMovies(movies: [Movie]) {
        realmService.AddOrUpdate(movies)
    }
    
    func saveSeries(serie: [Serie]) {
        realmService.AddOrUpdate(serie)
    }
    
}

extension PersistenceDataManager {
    
    private func saveCategories() {
        
    }
    
    private func saveGenreAndMovies(movies: [Movie]) {
        var movieGenres = [MoviesGenre]()
        for movie in movies {
            guard let genres = movie.genreIds else {
                return
            }
            for genre in genres {
                let mg = MoviesGenre()
                mg.setIds(genreId: genre, movieId: movie.id)
                movieGenres.append(mg)
            }
        }
        RealmService.shared.AddOrUpdate(movieGenres)
        let mgs = RealmService.shared.realm.objects(MoviesGenre.self)
        print("Hay \(mgs.count) genros de movies")
    }
    
    private func saveGenreAndSeries(series: [Serie]) {
        var seriesGenres = [SeriesGenre]()
        for serie in series {
            guard let genres = serie.genreIds else {
                return
            }
            for genre in genres {
                let sg = SeriesGenre()
                sg.setIds(genreId: genre, serieId: serie.id)
                seriesGenres.append(sg)
            }
        }
        RealmService.shared.AddOrUpdate(seriesGenres)
        let mgs = RealmService.shared.realm.objects(SeriesGenre.self)
        print("Hay \(mgs.count) genros de series")
    }
}
