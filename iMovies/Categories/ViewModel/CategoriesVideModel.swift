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
    public var moviesManager: MoviesManagerProtocol = MoviesDBManager()
    
    func loadGenres() -> Observable<[Genre]>{
        return moviesManager.getGenres()
    }
    
}
