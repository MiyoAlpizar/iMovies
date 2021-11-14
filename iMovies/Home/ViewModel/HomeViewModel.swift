//
//  HomeViewModel.swift
//  iMovies
//
//  Created by Miyo on 13/11/21.
//

import Foundation
import RxSwift

class HomeViewModel {
    
    private weak var view: HomeView?
    private var router: HomeRouter?
    public var moviesManager: MoviesManagerProtocol = MoviesDBManager()
    
    func bind(view: HomeView, router: HomeRouter) {
        self.view = view
        self.router = router
        self.router?.setSourceView(view)
    }
    
    func getHomeMovies() -> Observable<[HomeMovies]> {
       return moviesManager.getHomeMovies()
    }
   
    
}
