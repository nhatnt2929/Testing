//
//  TrendingViewControllerTest.swift
//  AkiTravelUnitTest
//
//  Created by nhatnt on 7/3/20.
//  Copyright © 2020 Aki Travel. All rights reserved.
//

@testable import MockingProject
import XCTest

class LoginViewControllerTests: XCTestCase {
    var viewController: LoginViewController!
    
    override func setUp() {
        super.setUp()
        viewController = LoginViewController.instantiate()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_ibOutlet() {
        viewController.loadView()
        XCTAssertNotNil(viewController.emailTextField)
        XCTAssertNotNil(viewController.passTextField)
        XCTAssertNotNil(viewController.loginButton)
        XCTAssertNotNil(viewController.registerButton)
    }
}
