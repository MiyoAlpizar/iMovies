//
//  Movie.swift
//  iMovies
//
//  Created by Miyo on 13/11/21.
//

import Foundation
import RealmSwift

struct MovieResponse: Decodable {
    let results: [Movie]
}

class Movie: Object, Decodable {
    @objc dynamic var id: Int
    @objc dynamic var title: String
    @objc dynamic var backdropPath: String?
    @objc dynamic var posterPath: String?
    @objc dynamic var overview: String
    @objc dynamic var voteAverage: Double
    @objc dynamic var voteCount: Int
    @objc dynamic var releaseDate: String?
    var genreIds: List<Int>? = [].toList()
    
    var backdropURL: URL? {
        return URL(string: "https://image.tmdb.org/t/p/w500\(backdropPath ?? "")")
    }
    
    var posterURL: URL? {
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath ?? "")")
    }
    
    override class func primaryKey() -> String {
            return "id"
    }
    
    override static func ignoredProperties() -> [String] {
        return ["backdropURL", "posterURL"]
    }
    
}
