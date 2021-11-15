//
//  SeacrhViewModel.swift
//  iMovies
//
//  Created by Miyo on 14/11/21.
//

import Foundation
import RxSwift

class SearchViewModel {
    private weak var view: SearchView?
    private var router: SearchRouter?
    public var moviesManager = MoviesManagerHelper.shared.manager
    
    func bind(view: SearchView, router: SearchRouter) {
        self.view = view
        self.router = router
        self.router?.setSourceView(view)
    }
    
    func loadShows(type: ShowType) -> Observable<[ShowInfo]>{
        return moviesManager.getShowsByCategory(type: type, category: ShowCategory.topRated)
    }
}
