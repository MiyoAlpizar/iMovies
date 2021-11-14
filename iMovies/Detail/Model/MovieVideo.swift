//
//  MovieVideo.swift
//  iMovies
//
//  Created by Miyo on 14/11/21.
//

import Foundation

// MARK: - MovieVideoResult
struct MovieVideoResult: Decodable {
    let id: Int
    let results: [MovieVideo]
}

// MARK: - Result
struct MovieVideo: Decodable {
    let name, key: String
    let site: String
    let size: Int
    let type: String
    let official: Bool
    let publishedAt, id: String
}
