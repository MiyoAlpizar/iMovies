//
//  Genre.swift
//  iMovies
//
//  Created by Miyo on 14/11/21.
//

import Foundation
import RealmSwift

struct GenreResponse: Decodable {
    let genres: [Genre]
}

class Genre: Object, Decodable {
    @objc dynamic var id: Int
    @objc dynamic var name: String
    
    override class func primaryKey() -> String {
            return "id"
    }
}
