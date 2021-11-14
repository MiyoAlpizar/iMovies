//
//  APIService.swift
//  iMovies
//
//  Created by Miyo on 13/11/21.
//

import Foundation

enum APIService {
    
    
    
    static func fetch<T: Decodable>(from url: URL, params: [String: String]? = nil) async throws -> T {
        var  urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        
        var queryItems = [URLQueryItem(name: "api_key", value: Constants.Keys.APIKEY)]
        if let params = params {
            queryItems.append(contentsOf: params.map { URLQueryItem(name: $0.key, value: $0.value)})
        }
        urlComponents.queryItems = queryItems
        let finalUrl = urlComponents.url!
        
        let decoder = Utils.jsonDecoder
        let task = Task { () -> T in
            let data = try Data(contentsOf: finalUrl)
            let decodedData = try decoder.decode(T.self, from: data)
            return decodedData
        }
        let result = try await task.value
        print(result)
        return result
    }
}
