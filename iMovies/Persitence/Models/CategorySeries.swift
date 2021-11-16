//
//  CategorySeries.swift
//  iMovies
//
//  Created by Miyo on 15/11/21.
//

import Foundation
import RealmSwift

class CategorySeries: Object {
    @objc dynamic var category: String = ""
    var idSeries = List<Int>()
    
    override class func primaryKey() -> String {
            return "category"
    }
}
