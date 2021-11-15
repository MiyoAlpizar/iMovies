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
    func getVideos(type: ShowType, id: Int) -> Observable<[MovieVideo]>
    func getGenres() -> Observable<[Genre]>
    func getMoviesByGenre(id:Int) -> Observable<[Movie]>
    func getMoviesByCategory(catgeory:MovieCategory) -> Observable<[Movie]>
    func filterMovies(text:String) -> Observable<[Movie]>
    
    func getSeriesByGenre(id:Int) -> Observable<[Serie]>
    func getSeriesByCategory(catgeory:MovieCategory) -> Observable<[Serie]>
    func filterSeries(text:String) -> Observable<[Serie]>
    
    func getHomePosters(type: ShowType) -> Observable<[Poster]>
    
}


