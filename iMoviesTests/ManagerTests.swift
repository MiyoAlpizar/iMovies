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
    
    //should return an array of ShowInfo as always there is internet connection
    func testShowsByCategory() {
        var shows = [ShowInfo]()
        let expectation = expectation(description: "Waiting for result")
        
        let manager: MoviesManagerProtocol = MoviesDBManager()
        
        manager.getShowsByCategory(type: ShowType.movie, category: ShowCategory.popular)
            .observe(on: MainScheduler.instance)
            .subscribe(on: MainScheduler.instance)
            .subscribe { _shows in
                shows = _shows
            }
            onError: { error in
                print(error.localizedDescription)
            }
            onCompleted: {
                XCTAssertGreaterThan(shows.count, 0)
                expectation.fulfill()
            }.disposed(by: disposedBag)
        waitForExpectations(timeout: 0.1)
    }
    
    //should return an array of ShowInfo no matter if there is internet connection
    func testShowsByCategoryOnlineOffline() {
        var shows = [ShowInfo]()
        let expectation = expectation(description: "Waiting for result")
        let manager: MoviesManagerProtocol = MoviesManagerHelper.shared.manager
        
        manager.getShowsByCategory(type: ShowType.movie, category: ShowCategory.popular)
            .observe(on: MainScheduler.instance)
            .subscribe(on: MainScheduler.instance)
            .subscribe { _shows in
                shows = _shows
            }
            onError: { error in
                print(error.localizedDescription)
            }
            onCompleted: {
                XCTAssertGreaterThan(shows.count, 0)
                expectation.fulfill()
            }.disposed(by: disposedBag)
        waitForExpectations(timeout: 0.1)
    }
    
    //should return the same movie searching online and then offline
    func testSameMovieOnlineOffLine() {
        let movieTitle = "Apex"
        
        var onlineMovie: ShowInfo?
        var offlineMovie: ShowInfo?
        
        let expectation = expectation(description: "Waiting for result")
        
        let onlineManager: MoviesManagerProtocol = MoviesDBManager()
        let offlineManager: MoviesManagerProtocol = MoviesLocalDBManager()
        
        onlineManager.searchShows(type: ShowType.movie, query: movieTitle)
            .observe(on: MainScheduler.instance)
            .subscribe(on: MainScheduler.instance)
            .subscribe { shows in
                guard shows.count > 0 else {
                    return
                }
                onlineMovie = shows[0]
            } onError: { error in
                XCTAssertTrue(false, error.localizedDescription)
            } onCompleted: {
                
                offlineManager.searchShows(type: .movie, query: movieTitle)
                    .observe(on: MainScheduler.instance)
                    .subscribe(on: MainScheduler.instance)
                    .subscribe { shows in
                        guard shows.count > 0 else {
                            return
                        }
                        offlineMovie = shows[0]
                    } onError: { error in
                        XCTAssertTrue(false, error.localizedDescription)
                    } onCompleted: {
                        XCTAssertEqual(onlineMovie?.id, offlineMovie?.id)
                        expectation.fulfill()
                    }.disposed(by: self.disposedBag)
                
            }.disposed(by: disposedBag)
        
        waitForExpectations(timeout: 0.5)
    }
    
    
    
    
    
}
