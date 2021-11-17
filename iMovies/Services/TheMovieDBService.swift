//
//  MovieService.swift
//  iMovies
//
//  Created by Miyo on 13/11/21.
//

import Foundation

import Foundation

class TheMovieDBService: TheMovieDBServiceProtocol {
    static let shared = TheMovieDBService()
    private init() {}
    private let apiKey = "352b18bc177a50f14c037b2549d7c6c9"
    private let baseAPIURL = "https://api.themoviedb.org/3"
    private let urlSession = URLSession.shared
    private let jsonDecoder = Utils.jsonDecoder
    
    func fetchMovies(category: ShowCategory, completion: @escaping (Result<MovieResponse, MovieError>) -> ()) {
        guard let url = URL(string: "\(baseAPIURL)/movie/\(category.rawValue)") else {
            completion(.failure(.invalidEndpoint))
            return
        }
        APIService.shared.loadURLAndDecode(url: url, completion: completion)
    }
    
    func fetchMovie(id: Int, completion: @escaping (Result<Movie, MovieError>) -> ()) {
        guard let url = URL(string: "\(baseAPIURL)/movie/\(id)") else {
            completion(.failure(.invalidEndpoint))
            return
        }
        APIService.shared.loadURLAndDecode(url: url, params: ["append_to_response": "videos,credits"] ,completion: completion)
    }
    
    func fetchVideos(id: Int, type: ShowType, completion: @escaping (Result<MovieVideoResult, MovieError>) -> ()) {
        guard let url = URL(string: "\(baseAPIURL)/\(type.rawValue)/\(id)/videos") else {
            completion(.failure(.invalidEndpoint))
            return
        }
        APIService.shared.loadURLAndDecode(url: url, completion: completion)
    }
    
    func fetchGenres(type: ShowType, completion: @escaping (Result<GenreResponse, MovieError>) -> ()) {
        guard let url = URL(string: "\(baseAPIURL)/genre/\(type.rawValue)/list") else {
            completion(.failure(.invalidEndpoint))
            return
        }
        APIService.shared.loadURLAndDecode(url: url, completion: completion)
    }
    
    func fetchMovieByGener(id: Int, completion: @escaping (Result<MovieResponse, MovieError>) -> ()) {
        guard let url = URL(string: "\(baseAPIURL)/discover/movie") else {
            completion(.failure(.invalidEndpoint))
            return
        }
        APIService.shared.loadURLAndDecode(url: url,
                              params: [
                                "language": Locale.current.languageCode ?? "en-US",
                                "include_adult": "true",
                                "with_genres": id.description
                               ],
                              completion: completion)
    }
    
    func fetchSeries(category: ShowCategory, completion: @escaping (Result<SerieResults, MovieError>) -> ()) {
        guard let url = URL(string: "\(baseAPIURL)/tv/\(category.rawValue)") else {
            completion(.failure(.invalidEndpoint))
            return
        }
        APIService.shared.loadURLAndDecode(url: url, completion: completion)
    }
    
    func fetchSeriesByGener(id: Int, completion: @escaping (Result<SerieResults, MovieError>) -> ()) {
        guard let url = URL(string: "\(baseAPIURL)/discover/tv") else {
            completion(.failure(.invalidEndpoint))
            return
        }
        APIService.shared.loadURLAndDecode(url: url,
                              params: [
                                "language": Locale.current.languageCode ?? "en-US",
                                "include_adult": "true",
                                "with_genres": id.description
                               ],
                              completion: completion)
    }
    
    func fetchSerie(id: Int, completion: @escaping (Result<Serie, MovieError>) -> ()) {
        guard let url = URL(string: "\(baseAPIURL)/tv/\(id)") else {
            completion(.failure(.invalidEndpoint))
            return
        }
        APIService.shared.loadURLAndDecode(url: url, params: ["append_to_response": "videos,credits"] ,completion: completion)
    }
    
    func searchMovies(query: String, completion: @escaping (Result<MovieResponse, MovieError>) -> ()) {
        guard let url = URL(string: "\(baseAPIURL)/search/movie") else {
            completion(.failure(.invalidEndpoint))
            return
        }
        APIService.shared.loadURLAndDecode(url: url,
                              params: [
                                "language": Locale.current.languageCode ?? "en-US",
                                "include_adult": "true",
                                "query": query
                               ],
                              completion: completion)
    }
    
    func searchSeries(query: String, completion: @escaping (Result<SerieResults, MovieError>) -> ()) {
        guard let url = URL(string: "\(baseAPIURL)/search/tv") else {
            completion(.failure(.invalidEndpoint))
            return
        }
        APIService.shared.loadURLAndDecode(url: url,
                              params: [
                                "language": Locale.current.languageCode ?? "en-US",
                                "include_adult": "true",
                                "query": query
                               ],
                              completion: completion)
    }
    
    func fetchSimilarMovies(id: Int, completion: @escaping (Result<MovieResponse, MovieError>) -> ()) {
        guard let url = URL(string: "\(baseAPIURL)/movie/\(id)/similar") else {
            completion(.failure(.invalidEndpoint))
            return
        }
        APIService.shared.loadURLAndDecode(url: url, completion: completion)
    }
    
    func fetchSimilarSeries(id: Int, completion: @escaping (Result<SerieResults, MovieError>) -> ()) {
        guard let url = URL(string: "\(baseAPIURL)/tv/\(id)/simial") else {
            completion(.failure(.invalidEndpoint))
            return
        }
        APIService.shared.loadURLAndDecode(url: url, completion: completion)
    }
}
