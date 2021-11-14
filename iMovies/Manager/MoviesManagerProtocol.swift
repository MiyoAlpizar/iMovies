//
//  MoviesManagerProtocol.swift
//  iMovies
//
//  Created by Miyo on 13/11/21.
//

import Foundation
import RxSwift

protocol MoviesManagerProtocol {
    func getHomeMovies() -> Observable<[HomeMovies]>
}
