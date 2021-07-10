//
//  MovieModelTests.swift
//  MovsTests
//
//  Created by gustavo.cosenza on 08/07/21.
//  Copyright © 2021 gustavo.cosenza. All rights reserved.
//

import XCTest
@testable import Movs

class MovieModelTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_correctReleaseYear() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let movie = Movie(voteCount: 3, id: 3, video: false, voteAverage: 0.0, title: "Teste", popularity: 0.0, posterPath: "teste", originalLanguage: "teste", originalTitle: "teste", genreIDS: [2], backdropPath: "teste", adult: false, overview: "teste", releaseDate: "2021-06-17")
        XCTAssertEqual(movie.releaseYear, "2021")
    }
}
