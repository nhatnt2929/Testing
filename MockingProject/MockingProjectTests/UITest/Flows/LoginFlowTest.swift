//
//  TrendingFlow.swift
//  AkiTravelUITests
//
//  Created by nhatnt on 7/6/20.
//  Copyright © 2020 Aki Travel. All rights reserved.
//

@testable import MockingProject
import KIF

class LoginFlowTests: KIFTestCase {
    private struct DATA_TESTING {
        static let EMAIL_SUCCESS = "nhant@nal.vn"
        static let PASSWORD_SUCCESS = "abcd12311114"
        
        static let EMAIL_FAILED = "emailfailed"
        static let PASSWORD_FAILED = "ab"
    }
    
    override func setUp() {
        super.setUp()
    }
    
    override func beforeEach() {
        super.beforeEach()
        clearLoginTextField()
        tester().tapView(withAccessibilityLabel: TabBarItemType.login.title)
    }
    
    override func afterEach() {
        super.afterEach()
    }

    override func tearDown() {
        super.tearDown()
        tester().tapView(withAccessibilityLabel: TabBarItemType.login.title)
    }
    
    fileprivate func clearLoginTextField() {
        tester().clearTextFromView(withAccessibilityLabel: AccessibilityLabels.login_email_accessibility)
        tester().clearTextFromView(withAccessibilityLabel: AccessibilityLabels.login_password_accessibility)
    }
    
    func test_login_flow_success() {
        //stub api
        stub_login_success()
        //actions
        tester().enterText(DATA_TESTING.EMAIL_SUCCESS,
                       intoViewWithAccessibilityLabel: AccessibilityLabels.login_email_accessibility)
        tester().enterText(DATA_TESTING.PASSWORD_SUCCESS,
                           intoViewWithAccessibilityLabel: AccessibilityLabels.login_password_accessibility)
        tester().tapView(withAccessibilityLabel: AccessibilityLabels.login_button_accessibility)
        // assert
        tester().waitForView(withAccessibilityLabel: AccessibilityLabels.home_accessibility)
    }

    func test_login_validate_disable() {
        //actions
        tester().enterText(DATA_TESTING.EMAIL_FAILED,
                       intoViewWithAccessibilityLabel: AccessibilityLabels.login_email_accessibility)
        tester().enterText(DATA_TESTING.PASSWORD_FAILED,
                           intoViewWithAccessibilityLabel: AccessibilityLabels.login_password_accessibility)
        // assert
        let loginButton = tester().waitForView(withAccessibilityLabel: AccessibilityLabels.login_button_accessibility) as! UIButton
        XCTAssertFalse(loginButton.isEnabled)
        XCTAssertEqual(loginButton.alpha, LoginConstants.loginAlphaDisable)
    }

    func test_login_validate_enable() {
        //actions
        tester().enterText(DATA_TESTING.EMAIL_SUCCESS,
                       intoViewWithAccessibilityLabel: AccessibilityLabels.login_email_accessibility)
        tester().enterText(DATA_TESTING.PASSWORD_SUCCESS,
                           intoViewWithAccessibilityLabel: AccessibilityLabels.login_password_accessibility)
        // assert
        let loginButton = tester().waitForView(withAccessibilityLabel: AccessibilityLabels.login_button_accessibility) as! UIButton
        XCTAssert(loginButton.isEnabled)
        XCTAssertEqual(loginButton.alpha, LoginConstants.loginAlphaEnable)
    }

    func test_register_flow_success() {
        //actions
        tester().tapView(withAccessibilityLabel: AccessibilityLabels.register_button_accessibility)
        tester().enterText(DATA_TESTING.EMAIL_SUCCESS, intoViewWithAccessibilityLabel: AccessibilityLabels.register_email_accessibility)
        tester().enterText(DATA_TESTING.PASSWORD_SUCCESS, intoViewWithAccessibilityLabel: AccessibilityLabels.register_pass_accessibility)
        tester().enterText("John", intoViewWithAccessibilityLabel: AccessibilityLabels.register_name_accessibility)

        tester().tapView(withAccessibilityLabel: AccessibilityLabels.register_toHome_accessibility)

        //assert
        tester().waitForView(withAccessibilityLabel: AccessibilityLabels.home_accessibility)
    }

    func test_register_select_action_tableView() {
        //actions
        tester().tapView(withAccessibilityLabel: AccessibilityLabels.register_button_accessibility)
        tester().enterText(DATA_TESTING.EMAIL_SUCCESS, intoViewWithAccessibilityLabel: AccessibilityLabels.register_email_accessibility)
        tester().enterText(DATA_TESTING.PASSWORD_SUCCESS, intoViewWithAccessibilityLabel: AccessibilityLabels.register_pass_accessibility)
        tester().enterText("John", intoViewWithAccessibilityLabel: AccessibilityLabels.register_name_accessibility)
        tester().tapView(withAccessibilityLabel: AccessibilityLabels.register_toHome_accessibility)

        //assert
        tester().waitForView(withAccessibilityLabel: AccessibilityLabels.home_accessibility)

        //actions
        tester().tapRow(at: IndexPath(item: 0, section: 0), inTableViewWithAccessibilityIdentifier: AccessibilityIdentifiers.home_tableView_accessibility)

        //assert
        tester().waitForView(withAccessibilityLabel: AccessibilityLabels.login_accessibility)
    }
    
    func test_login_flow_failed() {
        //stub api
        stub_login_failed()
        //actions
        tester().enterText(DATA_TESTING.EMAIL_SUCCESS,
                       intoViewWithAccessibilityLabel: AccessibilityLabels.login_email_accessibility)
        tester().enterText(DATA_TESTING.PASSWORD_SUCCESS,
                           intoViewWithAccessibilityLabel: AccessibilityLabels.login_password_accessibility)
        tester().tapView(withAccessibilityLabel: AccessibilityLabels.login_button_accessibility)
        // assert
        
        let errorLabel = tester().waitForView(withAccessibilityLabel: AccessibilityLabels.login_error_accessibility) as! UILabel
        XCTAssertFalse(errorLabel.isHidden)
    }
}
