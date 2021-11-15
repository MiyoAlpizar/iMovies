//
//  MovieServiceProtocol.swift
//  iMovies
//
//  Created by Miyo on 13/11/21.
//

import Foundation
import RxSwift

///Protocol to get movies info from  https://www.themoviedb.org
protocol TheMovieDBServiceProtocol {
    func fetchMovie(id: Int, completion: @escaping(Result<Movie, MovieError>) -> ())
    func seacrhMovie(query: String, completion: @escaping(Result<MovieResponse, MovieError>) -> ())
    func fetchVideos(id: Int, type: ShowType, completion: @escaping(Result<MovieVideoResult, MovieError>) -> ())
    func fetchGenres(completion: @escaping(Result<GenreResponse, MovieError>) -> ())
    func fetchMovieByGener(id: Int, completion: @escaping(Result<MovieResponse, MovieError>) ->())
    
    func fetchSeries(category: MovieCategory, completion: @escaping(Result<SerieResults, MovieError>) -> ())
    func fetchSerie(id: Int, completion: @escaping(Result<Serie, MovieError>) -> ())
    func seacrhSeries(query: String, completion: @escaping(Result<SerieResults, MovieError>) -> ())
    func fetchSeriesByGener(id: Int, completion: @escaping(Result<SerieResults, MovieError>) ->())
}

enum MovieCategory: String {
    case nowPlaying = "now_playing"
    case upcoming
    case topRated = "top_rated"
    case popular
    case latest
    case airingToday = "airing_today"
    case onTheAir = "on_the_air"
    var description: String {
        switch self {
        case .nowPlaying:
            return NSLocalizedString("Now Playing", comment: "")
        case .upcoming:
            return NSLocalizedString("Upcoming", comment: "")
        case .topRated:
            return NSLocalizedString("Top Rated", comment: "")
        case .popular:
            return NSLocalizedString("Popular", comment: "")
        case .latest:
            return NSLocalizedString("Latest", comment: "")
        case .airingToday:
            return NSLocalizedString("Aring Today", comment: "")
        case .onTheAir:
            return NSLocalizedString("On The Air", comment: "")
        }
    }
}

enum MovieError: Error, CustomNSError {
    case apiError
    case invalidEndpoint
    case invalidResponse
    case noData
    case seralizationError
    var localizedDescription: String {
        switch self {
        case .apiError:
            return NSLocalizedString("Failed to fecth data", comment: "")
        case .invalidEndpoint:
            return NSLocalizedString("Invalid endpoint", comment: "")
        case .invalidResponse:
            return NSLocalizedString("Invalid response", comment: "")
        case .noData:
            return NSLocalizedString("No data", comment: "")
        case .seralizationError:
            return NSLocalizedString("Failed to decode data", comment: "")
        }
    }
    
    var errorUserInfo: [String : Any] {
        [NSLocalizedDescriptionKey: localizedDescription]
    }
    
}
