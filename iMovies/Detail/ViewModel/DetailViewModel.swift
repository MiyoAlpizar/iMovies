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
    
    
    func loadVideos(id: Int, type: ShowType) -> Observable<[MovieVideo]> {
        return MoviesManagerHelper.shared.manager.getVideos(type: type, id: id)
    }
    
    func loadSimilarShows(type: ShowType, id: Int) -> Observable<[ShowInfo]> {
        return MoviesManagerHelper.shared.manager.getSimilarShows(type: type, id: id)
    }
    
}
