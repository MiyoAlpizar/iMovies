//
//  MoviesDBManager+CastFunc.swift
//  iMovies
//
//  Created by Miyo on 15/11/21.
//

import Foundation

extension MoviesDBManager {
    
    func castMoviesToShowInfo(movies: [Movie]) -> [ShowInfo]{
        var showsInfo = [ShowInfo]()
        for item in movies {
            if (item.posterPath != nil && item.backdropPath != nil) {
                showsInfo.append(castMovieToShowInfo(movie: item))
            }
        }
        return showsInfo
    }
    
    func castSeriesToShowInfo(series: [Serie]) -> [ShowInfo] {
        var showsInfo = [ShowInfo]()
        for item in series {
            if (item.posterPath != nil && item.backdropPath != nil) {
                showsInfo.append(castSerieToShowInfo(serie: item))
            }
        }
        return showsInfo
    }
    
    func castMovieToShowInfo(movie: Movie) -> ShowInfo {
        return ShowInfo(id: movie.id, portraitPoster: movie.posterURL, landscapePoster: movie.backdropURL, name: movie.title, overview: movie.overview, type: showType.movie)
    }
    
    func castSerieToShowInfo(serie: Serie) -> ShowInfo {
        return ShowInfo(id: serie.id, portraitPoster: serie.posterURL, landscapePoster: serie.backdropURL, name: serie.name, overview: serie.overview, type: showType.movie)
    }
    
}
