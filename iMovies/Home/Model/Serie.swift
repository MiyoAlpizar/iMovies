//
//  Serie.swift
//  iMovies
//
//  Created by Miyo on 14/11/21.
//

import Foundation

struct SerieResults : Decodable {
    let results: [Serie]
}
// MARK: - Serie
struct Serie: Decodable {
    let id: Int
    let name: String
    let backdropPath: String?
    let posterPath: String?
    let overview: String
    let voteAverage: Double
    let voteCount: Int
    let runtime: Int?
    let firstAirDate: String?
    
    var backdropURL: URL? {
        return URL(string: "https://image.tmdb.org/t/p/w500\(backdropPath ?? "")")
    }
    
    var posterURL: URL? {
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath ?? "")")
    }
    
}

