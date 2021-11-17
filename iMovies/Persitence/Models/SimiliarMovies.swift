//
//  SimiliarMovies.swift
//  iMovies
//
//  Created by Miyo on 16/11/21.
//

import RealmSwift

class SimilarMovies: Object {
    @objc dynamic var id: Int = 0
    var idMovies = List<Int>()
    override class func primaryKey() -> String {
            return "id"
    }
}
