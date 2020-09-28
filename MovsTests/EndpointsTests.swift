//
//  GenreManagerTests.swift
//  MovsTests
//
//  Created by gustavo.cosenza on 28/09/20.
//  Copyright © 2020 gustavo.cosenza. All rights reserved.
//

import XCTest
@testable import Movs

class EndpointsTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testUrlImageBackdrop() {
        let url = ImageEndpoints.backdropPath("/teste").url
        XCTAssertEqual(url.absoluteString, "https://image.tmdb.org/t/p/w300/teste")
        
    }

    func testUrlImagePoster() {
        let url = ImageEndpoints.posterPath("/teste").url
        XCTAssertEqual(url.absoluteString, "https://image.tmdb.org/t/p/w185/teste")
    }
    
    func testUrlMovies() {
        let url = Endpoints.urlMovies(1).url
        XCTAssertEqual(url.absoluteString, "https://api.themoviedb.org/3/movie/popular?page=1&language=en-US&api_key=e4aa100e47a2d27f927f4797a4bf5607")
    }
    
    func testUrlGenres() {
        let url = Endpoints.urlGenres.url
        XCTAssertEqual(url.absoluteString, "https://api.themoviedb.org/3/genre/movie/list?language=en-US&api_key=e4aa100e47a2d27f927f4797a4bf5607")
    }
    
}
