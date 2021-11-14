//
//  MoviesManagerHelper.swift
//  iMovies
//
//  Created by Miyo on 14/11/21.
//

import Foundation

class MoviesManagerHelper {
    static let shared = MoviesManagerHelper()
    private init() { }
    private(set) var manager: MoviesManagerProtocol = MoviesDBManager()
    
}

