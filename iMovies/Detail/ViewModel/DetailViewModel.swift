//
//  DetailViewModel.swift
//  iMovies
//
//  Created by Miyo on 14/11/21.
//

import UIKit
import RxSwift

class DetailViewModel {
    
    private weak var view: DetailView?
    private var router: DetailRouter?
    public var moviesManager: MoviesManagerProtocol = MoviesDBManager()
    
    func loadVideos(id: Int) -> Observable<[MovieVideo]> {
        return moviesManager.getMovieVideos(id: id)
    }
    
}
