//
//  MovieExtentions.swift
//  iMovies
//
//  Created by Miyo on 15/11/21.
//

import Foundation


extension Movie {
    
    func toShowInfo() -> ShowInfo {
        return ShowInfo(id: self.id, portraitPoster: self.posterURL, landscapePoster: self.backdropURL, name: self.title, overview: self.overview, type: .movie, voteAverage: self.voteAverage, voteCount: self.voteCount, date: self.releaseDate)
    }
}
