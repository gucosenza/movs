//
//  GenreManager.swift
//  MovsTests
//
//  Created by gustavo.cosenza on 28/09/20.
//  Copyright © 2020 gustavo.cosenza. All rights reserved.
//

import XCTest
@testable import Movs

class GenreManagerTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFuncGetGenres() {
        let genre = GenreManager()
        genre.dictionaryGenres = [1:"a", 2:"b"]
        let genresname = genre.getGenres(ids: [1,2])
        XCTAssertEqual(genresname, "a, b")
    }

}
