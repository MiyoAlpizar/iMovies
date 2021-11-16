//
//  MoviesGenre.swift
//  iMovies
//
//  Created by Miyo on 16/11/21.
//

import Foundation
import RealmSwift

class MoviesGenre: Object {
    @objc dynamic var genreId: Int = 0
    @objc dynamic var movieId: Int = 0
    @objc dynamic var compoundKey: String = UUID().uuidString
    
    func setIds(genreId: Int, movieId: Int) {
        self.genreId = genreId
        self.movieId = movieId
        compoundKey = compoundKeyValue()
    }
    
    override static func primaryKey() -> String? {
        return "compoundKey"
    }
    
    func compoundKeyValue() -> String {
        return "\(genreId)-\(movieId)"
    }
    
}
