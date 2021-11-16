//
//  GenerSeries.swift
//  iMovies
//
//  Created by Miyo on 16/11/21.
//

import Foundation
import RealmSwift

class GenerSeries: Object {
    @objc dynamic var showType: String = ""
    var idGeners = List<Int>()
    
    override class func primaryKey() -> String {
            return "showType"
    }
}
