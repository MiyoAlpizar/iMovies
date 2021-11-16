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
        
        //Get the movies Ids
        let ids = movies.reduce([Int](), { $0 + [$1.id] })
        
        //Create new object to store movies ids with category
        let categoryMovies = CategoryMovies()
        
        categoryMovies.category = category.rawValue
        categoryMovies.idMovies = ids.toList()
        
        //Add or update category movies array
        realmService.AddOrUpdate(categoryMovies)
        
        
        let _movies = realmService.realm.objects(Movie.self)
        let _categories = realmService.realm.objects(CategoryMovies.self)
        print("Hay \(_movies.count) Movies")
        print("Hay \(_categories.count) ShowCategories")
    }
    
    func saveSeriesCategory(category: ShowCategory, series: [Serie]) {
        
        //Add Or Update Series
        realmService.AddOrUpdate(series)
        
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
}
