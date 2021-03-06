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
    func fetchVideos(id: Int, type: ShowType, completion: @escaping(Result<MovieVideoResult, MovieError>) -> ())
    func fetchGenres(type: ShowType, completion: @escaping(Result<GenreResponse, MovieError>) -> ())
    func searchMovies(query: String, completion: @escaping(Result<MovieResponse, MovieError>) -> ())
    func searchSeries(query: String, completion: @escaping(Result<SerieResults, MovieError>) -> ())
    func fetchMovieByGener(id: Int, completion: @escaping(Result<MovieResponse, MovieError>) ->())
    func fetchSeriesByGenre(id: Int, completion: @escaping(Result<SerieResults, MovieError>) ->())
    func fetchMovies(category: ShowCategory, completion: @escaping(Result<MovieResponse, MovieError>) -> ())
    func fetchSeries(category: ShowCategory, completion: @escaping(Result<SerieResults, MovieError>) -> ())
    func fetchSerie(id: Int, completion: @escaping(Result<Serie, MovieError>) -> ())
    func fetchSimilarMovies(id: Int, completion: @escaping(Result<MovieResponse, MovieError>) ->())
    func fetchSimilarSeries(id: Int, completion: @escaping(Result<SerieResults, MovieError>) ->())
}

enum ShowCategory: String {
    case nowPlaying = "now_playing"
    case upcoming
    case topRated = "top_rated"
    case popular
    case latest
    case airingToday = "airing_today"
    case onTheAir = "on_the_air"
    case similiar = "similar"
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
        case .similiar:
            return NSLocalizedString("Similars", comment: "")
        }
    }
}

enum MovieError: Error, CustomNSError {
    case apiError
    case invalidEndpoint
    case invalidResponse
    case noData
    case seralizationError
    case noConnected
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
        case .noConnected:
            return NSLocalizedString("There is not internet connection", comment: "")
        }
    }
    
    var errorUserInfo: [String : Any] {
        [NSLocalizedDescriptionKey: localizedDescription]
    }
    
}
