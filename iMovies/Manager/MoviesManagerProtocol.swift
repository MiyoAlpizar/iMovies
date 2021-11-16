//
//  MoviesManagerProtocol.swift
//  iMovies
//
//  Created by Miyo on 13/11/21.
//

import Foundation
import RxSwift

/// Protocol to get any shows info
protocol MoviesManagerProtocol {
    func getHomeShows(type: ShowType) -> Observable<[Poster]>
    func getVideos(type: ShowType, id: Int) -> Observable<[MovieVideo]>
    func getMoviesByCategory(catgeory:ShowCategory) -> Observable<[Movie]>
    func getSeriesByCategory(category:ShowCategory) -> Observable<[Serie]>
    func getGenres(type: ShowType) -> Observable<[Genre]>
    func getShowsByGenre(type: ShowType, id: Int) -> Observable<[ShowInfo]>
    func getShowsByCategory(type: ShowType, category: ShowCategory) -> Observable<[ShowInfo]>
    func searchShows(type: ShowType, query: String) -> Observable<[ShowInfo]>
}

