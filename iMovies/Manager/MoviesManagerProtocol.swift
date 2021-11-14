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
    func getMovieVideos(id: Int) -> Observable<[MovieVideo]>
    func getGenres() -> Observable<[Genre]>
    func getMoviesByGenre(id:Int) -> Observable<[Movie]>
}
