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
    
    ///Should return  movies array as always as there is internet connection
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
    
    ///Should return  series array as always as there is internet connection
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
    
    ///Should return  genre array as always as there is internet connection
    func testFetchGenres() {
        service.fetchGenres(type: ShowType.serie) { results in
            switch results {
            case .success(let response):
                XCTAssertTrue(response.genres.count > 0)
            case .failure(let error):
                XCTAssertTrue(false, error.localizedDescription)
            }
        }
    }
}
