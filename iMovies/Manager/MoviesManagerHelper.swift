//
//  MoviesManagerHelper.swift
//  iMovies
//
//  Created by Miyo on 14/11/21.
//

import Foundation


///Manages movie manager when internet is gone or back
class MoviesManagerHelper: ReachabilityObserverDelegate {
    
    static let shared = MoviesManagerHelper()
    
    private init() {
        ///Observes for any internet connecion status changes
        try? addReachabilityObserver()
    }
    
    deinit {
        removeReachabilityObserver()
    }
    ///Fetching movies manager protocol
    private(set) var manager: MoviesManagerProtocol = MoviesDBManager()
    
    func reachabilityChanged(_ isReachable: Bool) {
        //if lost connection, will fetch movies from local data base persisted (offline)
        if !isReachable {
            manager = MoviesLocalDBManager()
        }else {
            manager = MoviesDBManager()
        }
    }
    
}

