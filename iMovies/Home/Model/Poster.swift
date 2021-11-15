//
//  Poster.swift
//  iMovies
//
//  Created by Miyo on 14/11/21.
//

import Foundation

struct ShowInfo: Equatable {
    let id: Int
    let portraitPoster: URL?
    let landscapePoster: URL?
    let name: String
    let overview: String
    let type: ShowType
    let voteAverage: Double
    let voteCount: Int
    let date: String?
}

struct Poster: Equatable {
    let category: ShowCategory
    var posters: [ShowInfo]
}
