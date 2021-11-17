//
//  APIService.swift
//  iMovies
//
//  Created by Miyo on 15/11/21.
//

import Foundation
import RealmSwift

class APIService {
    
    static var shared: APIService = APIService()
    
    private let apiKey = "352b18bc177a50f14c037b2549d7c6c9"
    let baseAPIURL = "https://api.themoviedb.org/3"
    private let urlSession = URLSession.shared
    private let jsonDecoder = Utils.jsonDecoder
   
   
    
    func loadURLAndDecode<D: Decodable>(url: URL, params: [String: String]? = nil, completion: @escaping(Result<D, MovieError>) -> ()) {
        guard ReachabilityHelper.shared.isReachable else {
            completion(.failure(.noConnected))
            return
        }
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



