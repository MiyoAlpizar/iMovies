//
//  SeriesGenre.swift
//  iMovies
//
//  Created by Miyo on 16/11/21.
//

import Foundation
import RealmSwift

class SeriesGenre: Object {
    @objc dynamic var genreId: Int = 0
    @objc dynamic var serieId: Int = 0
    @objc dynamic var compoundKey: String = UUID().uuidString
    
    func setIds(genreId: Int, serieId: Int) {
        self.genreId = genreId
        self.serieId = serieId
        compoundKey = compoundKeyValue()
    }
    
    override static func primaryKey() -> String? {
        return "compoundKey"
    }
    
    func compoundKeyValue() -> String {
        return "\(genreId)-\(serieId)"
    }
}
