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
     
    func bind(view: HomeView, router: HomeRouter) {
        self.view = view
        self.router = router
        self.router?.setSourceView(view)
    }
    
    func getHomePosters(type: ShowType) -> Observable<[Poster]> {
        return MoviesManagerHelper.shared.manager.getHomeShows(type: type)
    }
    
   
   
    
}
