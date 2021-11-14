//
//  CategoriesVideModel.swift
//  iMovies
//
//  Created by Miyo on 14/11/21.
//

import UIKit
import RxSwift

class CategoriesViewModel {
    
    private weak var view: CategoriesView?
    private var router: CategoriesRouter?
    public var moviesManager = MoviesManagerHelper.shared.manager
    
    func bind(view: CategoriesView, router: CategoriesRouter) {
        self.view = view
        self.router = router
        self.router?.setSourceView(view)
    }
    
    func loadGenres() -> Observable<[Genre]>{
        return moviesManager.getGenres()
    }
    
}
