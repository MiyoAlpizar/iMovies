//
//  MoviesManagerHelper.swift
//  iMovies
//
//  Created by Miyo on 14/11/21.
//

import Foundation

class MoviesManagerHelper: ReachabilityObserverDelegate {
    
    
    static let shared = MoviesManagerHelper()
    
    private init() {
        try? addReachabilityObserver()
    }
    
    deinit {
        removeReachabilityObserver()
    }
    
    private(set) var manager: MoviesManagerProtocol = MoviesDBManager()
    
    func reachabilityChanged(_ isReachable: Bool) {
        //If lost connection, will fetch moview from local data base persisted
        if !isReachable {
            manager = MoviesSQLiteManager()
        }else {
            manager = MoviesDBManager()
        }
    }
    
}

