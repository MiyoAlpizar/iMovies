//
//  MoviesGenerViewModel.swift
//  iMovies
//
//  Created by Miyo on 14/11/21.
//

import Foundation
import RxSwift

class MoviesGenreViewModel {
    
    private weak var view: MoviesGenreView?
    private var router: MoviesGenreRouter?
    public var moviesManager = MoviesManagerHelper.shared.manager
    
    func bind(view: MoviesGenreView, router: MoviesGenreRouter) {
        self.view = view
        self.router = router
        self.router?.setSourceView(view)
    }
    
    func loadMoviesByGenre(id: Int) -> Observable<[Movie]>{
        return moviesManager.getMoviesByGenre(id: id)
    }
    
    func searchMovies(text: String) -> Observable<[Movie]>{
        return moviesManager.filterMovies(text: text)
    }
}
