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
    
    func bind(view: ShowsView, router: ShowsRouter) {
        self.view = view
        self.router = router
        self.router?.setSourceView(view)
    }
    
    func loadShowsByGenre(type: ShowType,id: Int) -> Observable<[ShowInfo]>{
        return MoviesManagerHelper.shared.manager.getShowsByGenre(type: type, id: id)
    }
    
    func filterShows(type: ShowType, query: String) -> Observable<[ShowInfo]> {
        return MoviesManagerHelper.shared.manager.searchShows(type: type, query: query)
    }
}
