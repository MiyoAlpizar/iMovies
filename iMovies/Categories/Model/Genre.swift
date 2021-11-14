//
//  Genre.swift
//  iMovies
//
//  Created by Miyo on 14/11/21.
//

import Foundation

struct GenreResponse: Decodable {
    let genres: [Genre]
}

struct Genre: Decodable {
    let id: Int
    let name: String
}
