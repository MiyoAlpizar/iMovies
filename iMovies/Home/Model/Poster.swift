//
//  Poster.swift
//  iMovies
//
//  Created by Miyo on 14/11/21.
//

import Foundation

struct ShowInfo {
    let id: Int
    let portraitPoster: URL?
    let landscapePoster: URL?
    let name: String
    let overview: String
    let type: showType
}

struct Poster {
    let category: MovieCategory
    var posters: [ShowInfo]
}
