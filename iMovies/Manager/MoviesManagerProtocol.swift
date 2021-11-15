//
//  MoviesManagerProtocol.swift
//  iMovies
//
//  Created by Miyo on 13/11/21.
//

import Foundation
import RxSwift

/// Protocol to fetch movies info
protocol MoviesManagerProtocol {
    func getVideos(type: ShowType, id: Int) -> Observable<[MovieVideo]>
    func getMoviesByCategory(catgeory:ShowCategory) -> Observable<[Movie]>
    func getSeriesByCategory(catgeory:ShowCategory) -> Observable<[Serie]>
    func getGenres(type: ShowType) -> Observable<[Genre]>
    func getShowsByGenre(type: ShowType, id: Int) -> Observable<[ShowInfo]>
    func getShowsByCategory(type: ShowType, category: ShowCategory) -> [ShowInfo]
    
    
    func getHomePosters(type: ShowType) -> Observable<[Poster]>
    
}


