//
//  TrendingViewModelTest.swift
//  AkiTravelUnitTest
//
//  Created by nhatnt on 7/3/20.
//  Copyright © 2020 Aki Travel. All rights reserved.
//

@testable import MockingProject
import XCTest
import RxSwift
import RxBlocking
import Foundation
import RxCocoa

class LoginViewModelTest: XCTestCase {
    var viewModel: LoginViewModel!
    var navigator: LoginNavigatorMock!
    var usecase: LoginUseCaseMock!
    var disposeBag: DisposeBag!
    
    struct DATA_TESTING {
        static let EMAIL_SUCCESS = "testing@nal.vn"
        static let EMAIL_FAILED = "testing"
        
        static let PASSWORD_SUCCESS = "abcd1234"
        static let PASSWORD_FAILED = "12"
    }
    
    private var input: LoginViewModel.Input!
    private var output: LoginViewModel.Output!
    
    fileprivate var validatePublishSubject = PublishSubject<(email: String, pass: String)>()
    fileprivate var loginPublishSubject = PublishSubject<(email: String, pass: String)>()
    fileprivate var registerPublishSubject = PublishSubject<Void>()
    fileprivate var toHomePublishSubject = PublishSubject<Void>()
    
    override func setUp() {
    super.setUp()
        navigator = LoginNavigatorMock()
        usecase = LoginUseCaseMock()
        
        viewModel = LoginViewModel(useCase: usecase, navigator: navigator)
        disposeBag = DisposeBag()
        input = LoginViewModel.Input(validateForm: validatePublishSubject.asDriverOnErrorJustComplete(),
                                     callLogin: loginPublishSubject.asDriverOnErrorJustComplete(),
                                     toRegister: registerPublishSubject.asDriverOnErrorJustComplete(),
                                     toHomeTrigger: toHomePublishSubject.asDriverOnErrorJustComplete())
        
        output = viewModel.transform(input)
        
        output.validateForm.drive().disposed(by: disposeBag)
        output.callLogin.drive().disposed(by: disposeBag)
        output.toRegister.drive().disposed(by: disposeBag)
        output.toHome.drive().disposed(by: disposeBag)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: TEST VALIDATE FORM
    func test_validateLogin_success() {
        validatePublishSubject.onNext((email: DATA_TESTING.EMAIL_SUCCESS, pass: DATA_TESTING.PASSWORD_SUCCESS))
        let validateTrue = try? output.validateForm.toBlocking().first()
        XCTAssert(usecase.validateForm_called)
        XCTAssert(validateTrue!)
    }
    
    func test_validateLogin_email_failed() {
        validatePublishSubject.onNext((email: DATA_TESTING.EMAIL_FAILED, pass: DATA_TESTING.PASSWORD_SUCCESS))
        let validateResult = try? output.validateForm.toBlocking().first()
        XCTAssert(usecase.validateForm_called)
        XCTAssertFalse(validateResult!)
    }
    
    func test_validateLogin_password_failed() {
        validatePublishSubject.onNext((email: DATA_TESTING.EMAIL_SUCCESS, pass: DATA_TESTING.PASSWORD_FAILED))
        let validateResult = try? output.validateForm.toBlocking().first()
        XCTAssert(usecase.validateForm_called)
        XCTAssertFalse(validateResult!)
    }
    
    // MARK: TEST CALL LOGIN
    func test_callLoginSuccess() {
        loginPublishSubject.onNext((email: String.random(), pass: String.random()))
        let loginResult = try? output.callLogin.toBlocking().first()
        XCTAssert(usecase.callLogin_called)
        XCTAssertNotNil(loginResult)
    }
    
    // MARK: TEST NAVIGATOR FORM
    func test_toHome() {
        toHomePublishSubject.onNext(())
        XCTAssert(navigator.toHomeVc_called)
    }
    
    func test_toRegister() {
        registerPublishSubject.onNext(())
        XCTAssert(navigator.toRegisterVc_called)
    }
}

//TEST CASE
//usecase
//1. validate
//    1.1 email valid && pass valid => success
//    1.2 email inValid && pass valid => failed
//    1.1 email valid && pass inValid => failed
//2. call login api
