//
//  MoviesManagerHelper.swift
//  iMovies
//
//  Created by Miyo on 14/11/21.
//

import Foundation


///Manages movie manager when internet is gone or back
class MoviesManagerHelper: ReachabilyDelegate {
    
    static let shared = MoviesManagerHelper()
    
    private init() {}
    
    func startListening() {
        ReachabilityHelper.shared.addListener(listener: self)
    }
    
    deinit {
        ReachabilityHelper.shared.removeListener(listener: self)
    }
    ///Fetching movies manager protocol
    var manager: MoviesManagerProtocol = MoviesLocalDBManager()
    
    func reachabilityChanged(_ isReachable: Bool) {
        //if lost connection, will fetch movies from local data base persisted (offline)
        if !isReachable {
            manager = MoviesLocalDBManager()
        }else {
            manager = MoviesDBManager()
        }
    }
    
}

