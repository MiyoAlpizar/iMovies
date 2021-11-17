//
//  ManagerTests.swift
//  iMoviesTests
//
//  Created by Miyo on 17/11/21.
//

import XCTest
@testable import iMovies
import RxSwift

class ManagerTests: XCTestCase {

    private var disposedBag = DisposeBag()
    private var shows = [ShowInfo]()
    //should return an array of ShowInfo
    func testShowsByCategory() throws {
        
        let manager: MoviesManagerProtocol = MoviesDBManager()
        
        manager.getShowsByCategory(type: ShowType.movie, category: ShowCategory.popular)
            .observe(on: MainScheduler.instance)
            .subscribe(on: MainScheduler.instance)
            .subscribe { shows in
                self.shows = shows
            }
            onError: { error in
                print(error.localizedDescription)
            }
            onCompleted: {
                XCTAssertTrue(self.shows.count > 0)
            }
                    
            .disposed(by: disposedBag)
    }
    
    //should return an array of Genre
    func testGetGenres() throws {
        
        let manager: MoviesManagerProtocol = MoviesDBManager()
        
        manager.getGenres(type: ShowType.movie)
            .observe(on: MainScheduler.instance)
            .subscribe(on: MainScheduler.instance)
            .subscribe { genres in
                XCTAssertTrue(genres.count > 0)
            } onError: { error in
                print(error.localizedDescription)
            }.disposed(by: disposedBag)
    }
    
    //should return at least one Movie with the extactly title
    func testSearchMovie() throws {
        
        let manager: MoviesManagerProtocol = MoviesDBManager()
        
        manager.searchShows(type: ShowType.movie, query: "How i met your murderer")
            .observe(on: MainScheduler.instance)
            .subscribe(on: MainScheduler.instance)
            .subscribe { movies in
                XCTAssertTrue(movies.count > 0)
            } onError: { error in
                print(error.localizedDescription)
            }.disposed(by: disposedBag)
    }
    
    //should return at least one serie with the extactly title
    func testSearchSerie() throws {
        
        let manager: MoviesManagerProtocol = MoviesDBManager()
        
        manager.searchShows(type: ShowType.serie, query: "How i met your mother")
            .observe(on: MainScheduler.instance)
            .subscribe(on: MainScheduler.instance)
            .subscribe { series in
                XCTAssertTrue(series.count > 0)
            } onError: { error in
                print(error.localizedDescription)
            }.disposed(by: disposedBag)
    }

}
