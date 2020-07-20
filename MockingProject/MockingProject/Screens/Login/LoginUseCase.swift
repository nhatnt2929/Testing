//
//  LoginUsecase.swift
//  MockingProject
//
//  Created by nhatnt on 7/1/20.
//  Copyright © 2020 eplus.epfs.ios. All rights reserved.
//

import Foundation
import RxSwift

protocol LoginUseCaseProtocol {
    func validateForm(email: String, pass: String) -> Observable<Bool>
    func callLogin(email: String, pass: String) -> Observable<Token>
}

struct LoginUseCase: LoginUseCaseProtocol {
    let repo: UserRepositoryProtocol
    func validateForm(email: String, pass: String) -> Observable<Bool> {
        return repo.validateForm(email: email, pass: pass)
    }
    
    func callLogin(email: String, pass: String) -> Observable<Token> {
        return repo.callLogin(email: email, pass: pass)
    }
}
