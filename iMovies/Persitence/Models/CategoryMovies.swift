//
//  CategoryMovies.swift
//  iMovies
//
//  Created by Miyo on 15/11/21.
//

import Foundation
import RealmSwift


class CategoryMovies: Object {
    @objc dynamic var category: String = ""
    var idMovies = List<Int>()
    
    override class func primaryKey() -> String {
            return "category"
    }
    
}
