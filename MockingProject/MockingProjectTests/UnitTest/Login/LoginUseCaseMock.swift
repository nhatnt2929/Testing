//
//  TrendingUseCaseMock.swift
//  AkiTravelUnitTest
//
//  Created by nhatnt on 7/3/20.
//  Copyright © 2020 Aki Travel. All rights reserved.
//

import Foundation
@testable import MockingProject
import RxSwift

final class LoginUseCaseMock: LoginUseCaseProtocol {
    let repo: UserRepositoryProtocol = UserRepository()
    var validateForm_called = false
    func validateForm(email: String, pass: String) -> Observable<Bool> {
        validateForm_called = true
        let valivateResult = repo.validateForm(email: email, pass: pass)
        return valivateResult
    }

    var callLogin_called = false
    var callLoginResult = Observable.just(Token.mock())
    func callLogin(email: String, pass: String) -> Observable<Token> {
        callLogin_called = true
        return callLoginResult
    }
}
