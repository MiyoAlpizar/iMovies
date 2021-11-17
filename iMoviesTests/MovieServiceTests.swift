//
//  MovieServiceTests.swift
//  iMoviesTests
//
//  Created by Miyo on 17/11/21.
//

import XCTest
@testable import iMovies

class MovieServiceTests: XCTestCase {
    
    let service: TheMovieDBServiceProtocol = TheMovieDBService.shared
    
    func testFetchMovies() {
        service.fetchMovies(category: ShowCategory.popular) { results in
            switch results {
            case .success(let response):
                XCTAssertTrue(response.results.count > 0)
            case .failure(let error):
                XCTAssertTrue(false, error.localizedDescription)
            }
        }
    }
    
    func testFetchSeries() {
        service.fetchSeries(category: ShowCategory.popular) { results in
            switch results {
            case .success(let response):
                XCTAssertTrue(response.results.count > 0)
            case .failure(let error):
                XCTAssertTrue(false, error.localizedDescription)
            }
        }
    }
}
