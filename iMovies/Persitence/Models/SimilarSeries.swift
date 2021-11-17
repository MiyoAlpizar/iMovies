//
//  SimilarSeries.swift
//  iMovies
//
//  Created by Miyo on 16/11/21.
//

import RealmSwift

class SimilarSeries: Object {
    @objc dynamic var id: Int = 0
    var idSeries = List<Int>()
    override class func primaryKey() -> String {
            return "id"
    }
}

