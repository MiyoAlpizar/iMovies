//
//  Serie+Extensions.swift
//  iMovies
//
//  Created by Miyo on 15/11/21.
//

import Foundation


extension Serie {
    
    func toShowInfo() -> ShowInfo {
        return ShowInfo(id: self.id, portraitPoster: self.posterURL, landscapePoster: self.backdropURL, name: self.name, overview: self.overview, type: .serie, voteAverage: self.voteAverage, voteCount: self.voteCount, date: self.firstAirDate)
    }
    
}
