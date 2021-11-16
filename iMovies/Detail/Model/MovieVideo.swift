//
//  MovieVideo.swift
//  iMovies
//
//  Created by Miyo on 14/11/21.
//

import Foundation
import RealmSwift

// MARK: - MovieVideoResult
struct MovieVideoResult: Decodable {
    let id: Int
    let results: [MovieVideo]
}

// MARK: - Result
class MovieVideo: Object, Decodable {
    @objc dynamic var name, key: String
    @objc dynamic var site: String
    @objc dynamic var size: Int
    @objc dynamic var type: String
    @objc dynamic var official: Bool
    @objc dynamic var publishedAt, id: String
}
