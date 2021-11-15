//
//  MoviesGenerViewModel.swift
//  iMovies
//
//  Created by Miyo on 14/11/21.
//

import Foundation
import RxSwift

class ShowsViewModel {
    
    private weak var view: ShowsView?
    private var router: ShowsRouter?
    public var moviesManager = MoviesManagerHelper.shared.manager
    
    func bind(view: ShowsView, router: ShowsRouter) {
        self.view = view
        self.router = router
        self.router?.setSourceView(view)
    }
    
    func loadShowsByGenre(type: ShowType,id: Int) -> Observable<[ShowInfo]>{
        return moviesManager.getShowsByGenre(type: type, id: id)
    }
    
    func filterShows(type: ShowType, query: String) -> Observable<[ShowInfo]> {
        return moviesManager.searchShows(type: type, query: query)
    }
}
