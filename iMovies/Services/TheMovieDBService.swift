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
        self.loadURLAndDecode(url: url, completion: completion)
    }
    
    func fetchMovie(id: Int, completion: @escaping (Result<Movie, MovieError>) -> ()) {
        guard let url = URL(string: "\(baseAPIURL)/movie/\(id)") else {
            completion(.failure(.invalidEndpoint))
            return
        }
        self.loadURLAndDecode(url: url, params: ["append_to_response": "videos,credits"] ,completion: completion)
    }
    
    func fetchVideos(id: Int, type: ShowType, completion: @escaping (Result<MovieVideoResult, MovieError>) -> ()) {
        guard let url = URL(string: "\(baseAPIURL)/\(type.rawValue)/\(id)/videos") else {
            completion(.failure(.invalidEndpoint))
            return
        }
        self.loadURLAndDecode(url: url, completion: completion)
    }
    
    func fetchGenres(type: ShowType, completion: @escaping (Result<GenreResponse, MovieError>) -> ()) {
        guard let url = URL(string: "\(baseAPIURL)/genre/\(type.rawValue)/list") else {
            completion(.failure(.invalidEndpoint))
            return
        }
        self.loadURLAndDecode(url: url, completion: completion)
    }
    
    func fetchMovieByGener(id: Int, completion: @escaping (Result<MovieResponse, MovieError>) -> ()) {
        guard let url = URL(string: "\(baseAPIURL)/discover/movie") else {
            completion(.failure(.invalidEndpoint))
            return
        }
        self.loadURLAndDecode(url: url,
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
        self.loadURLAndDecode(url: url, completion: completion)
    }
    
    func fetchSeriesByGener(id: Int, completion: @escaping (Result<SerieResults, MovieError>) -> ()) {
        guard let url = URL(string: "\(baseAPIURL)/discover/tv") else {
            completion(.failure(.invalidEndpoint))
            return
        }
        self.loadURLAndDecode(url: url,
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
        self.loadURLAndDecode(url: url, params: ["append_to_response": "videos,credits"] ,completion: completion)
    }
    
    func searchMovies(query: String, completion: @escaping (Result<MovieResponse, MovieError>) -> ()) {
        guard let url = URL(string: "\(baseAPIURL)/search/movie") else {
            completion(.failure(.invalidEndpoint))
            return
        }
        self.loadURLAndDecode(url: url,
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
        self.loadURLAndDecode(url: url,
                              params: [
                                "language": Locale.current.languageCode ?? "en-US",
                                "include_adult": "true",
                                "query": query
                               ],
                              completion: completion)
    }
}


extension TheMovieDBService {
    
    private func loadURLAndDecode<D: Decodable>(url: URL, params: [String: String]? = nil, completion: @escaping(Result<D, MovieError>) -> ()) {
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            completion(.failure(.invalidEndpoint))
            return
        }
        var queryItems = [URLQueryItem(name: "api_key", value: apiKey)]
        var _params = params
        if _params == nil {
            _params = ["language": Locale.current.languageCode ?? "en-US"]
        }
        
        if let params = _params {
            queryItems.append(contentsOf: params.map { URLQueryItem(name: $0.key, value: $0.value)})
        }
        
        urlComponents.queryItems = queryItems
        
        guard  let finalUrl = urlComponents.url else {
            completion(.failure(.invalidEndpoint))
            return
        }
        print(finalUrl)
        urlSession.dataTask(with: finalUrl) { [weak self] (data, response, error) in
            guard let self = self else { return }
            if let error = error {
                completion(.failure(.apiError))
                print(error.localizedDescription)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                self.executeCompletionHanlderInMainThread(with: .failure(.invalidResponse), completion: completion)
                return
            }
            
            guard let data = data else {
                self.executeCompletionHanlderInMainThread(with: .failure(.noData), completion: completion)
                return
            }
            
            do {
                let decodedResponse = try self.jsonDecoder.decode(D.self, from: data)
                self.executeCompletionHanlderInMainThread(with: .success(decodedResponse), completion: completion)
            }catch {
                self.executeCompletionHanlderInMainThread(with: .failure(.seralizationError), completion: completion)
            }
            
        }.resume()
        
       
        
    }
    
    private func executeCompletionHanlderInMainThread<D: Decodable>(with result: Result<D, MovieError>, completion: @escaping(Result<D, MovieError>) -> ()) {
        DispatchQueue.main.async {
            completion(result)
        }
    }
    
}
