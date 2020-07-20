//
//  MockingProjectUITests.swift
//  MockingProjectUITests
//
//  Created by nhatnt on 7/1/20.
//  Copyright © 2020 eplus.epfs.ios. All rights reserved.
//

import XCTest

class MockingProjectUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
    }

    func testExample() throws {
        let app = XCUIApplication()
        app.launch()
    }
}
