//
//  MovsUITests.swift
//  MovsUITests
//
//  Created by gustavo.cosenza on 19/07/20.
//  Copyright © 2020 gustavo.cosenza. All rights reserved.
//

import XCTest

class MovsUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
    
    func test_filterDontHaveMovieToShow() {
//        let app = XCUIApplication()
//        let search = app.searchFields["Search Movies"]
//        XCTAssertTrue(search.exists)
//        search.tap()
//        search.typeText("peninsula")
//        let message = app.staticTexts["Não existe filme para ser exibido"]
//        XCTAssertTrue(message.exists)
//        let cell = app.accessibility
//        XCTAssertTrue(cell.exists)
//        app.searchFields.accessibilityIden
        
        
//
//        let app = XCUIApplication()
//        app/*@START_MENU_TOKEN@*/.collectionViews.containing(.other, identifier:"Vertical scroll bar, 5 pages").element/*[[".collectionViews.containing(.other, identifier:\"Horizontal scroll bar, 1 page\").element",".collectionViews.containing(.other, identifier:\"Vertical scroll bar, 5 pages\").element"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
//
//        let rKey = app/*@START_MENU_TOKEN@*/.keys["R"]/*[[".keyboards.keys[\"R\"]",".keys[\"R\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
//        rKey.tap()
//        rKey.tap()
//
//        let oKey = app/*@START_MENU_TOKEN@*/.keys["o"]/*[[".keyboards.keys[\"o\"]",".keys[\"o\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
//        oKey.tap()
//        oKey.tap()
//
//        let gKey = app/*@START_MENU_TOKEN@*/.keys["g"]/*[[".keyboards.keys[\"g\"]",".keys[\"g\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
//        gKey.tap()
//        gKey.tap()
//
//        let uKey = app/*@START_MENU_TOKEN@*/.keys["u"]/*[[".keyboards.keys[\"u\"]",".keys[\"u\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
//        uKey.tap()
//        uKey.tap()
//
//        let eKey = app/*@START_MENU_TOKEN@*/.keys["e"]/*[[".keyboards.keys[\"e\"]",".keys[\"e\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
//        eKey.tap()
//        eKey.tap()
//        app/*@START_MENU_TOKEN@*/.buttons["Search"]/*[[".keyboards",".buttons[\"search\"]",".buttons[\"Search\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
//        app.collectionViews.cells.otherElements.containing(.staticText, identifier:"nameMovieCell").element.tap()
//
        
    }
}
