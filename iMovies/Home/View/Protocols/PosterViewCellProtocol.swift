//
//  PosterViewCellProtocol.swift
//  iMovies
//
//  Created by Miyo on 14/11/21.
//

import Foundation

protocol PosterViewCellProtocol: AnyObject {
    func onPosterPressed(movie: Movie)
}
