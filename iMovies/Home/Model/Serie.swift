//
//  Serie.swift
//  iMovies
//
//  Created by Miyo on 14/11/21.
//

import Foundation
import RealmSwift

struct SerieResults : Decodable {
    let results: [Serie]
}
// MARK: - Serie
class Serie: Object, Decodable {
    @objc dynamic var id: Int
    @objc dynamic var name: String
    @objc dynamic var backdropPath: String?
    @objc dynamic var posterPath: String?
    @objc dynamic var overview: String
    @objc dynamic var voteAverage: Double
    @objc dynamic var voteCount: Int
    @objc dynamic var firstAirDate: String?
    
    var backdropURL: URL? {
        return URL(string: "https://image.tmdb.org/t/p/w500\(backdropPath ?? "")")
    }
    
    var posterURL: URL? {
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath ?? "")")
    }
    
}

