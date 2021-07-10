//
//  ImageManagerTests.swift
//  MovsTests
//
//  Created by gustavo.cosenza on 08/07/21.
//  Copyright © 2021 gustavo.cosenza. All rights reserved.
//

import XCTest
@testable import Movs

class ImageManagerTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        let imageManager = ImageManager()
        let image: UIImage = imageManager.getImage(type: .backdrop, image: "teste")
//        image
    }

}
