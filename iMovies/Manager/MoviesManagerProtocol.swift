//
//  MoviesManagerProtocol.swift
//  iMovies
//
//  Created by Miyo on 13/11/21.
//

import Foundation
import RxSwift

/// Protocol to fecth movies info
protocol MoviesManagerProtocol {
    func getHomeMovies() -> Observable<[HomeMovies]>
    func getVideos(id: Int) -> Observable<[MovieVideo]>
    func getGenres() -> Observable<[Genre]>
    func getMoviesByGenre(id:Int) -> Observable<[Movie]>
    func getMoviesByCategory(catgeory:MovieCategory) -> Observable<[Movie]>
    func filterMovies(text:String) -> Observable<[Movie]>
    
    func getHomeSeries() -> Observable<[HomeSeries]>
    func getSeriesByGenre(id:Int) -> Observable<[Serie]>
    func getSeriesByCategory(catgeory:MovieCategory) -> Observable<[Serie]>
    func filterSeries(text:String) -> Observable<[Serie]>
    
    func getHomePosters(type: showType) -> Observable<[Poster]>
    
}


