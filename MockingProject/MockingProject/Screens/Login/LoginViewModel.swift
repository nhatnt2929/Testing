//
//  LoginViewModel.swift
//  MockingProject
//
//  Created by nhatnt on 7/1/20.
//  Copyright © 2020 eplus.epfs.ios. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Then

struct Validations {
static let regexEmail = "^[a-zA-Z0-9.!#$%&‘+/=?^_`{|}~-]+@(?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])+\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
}

struct LoginViewModel: ViewModelType {
    var useCase: LoginUseCaseProtocol
    var navigator: LoginNavigatorProtocol
    
    struct Input {
        var validateForm: Driver<(email: String, pass: String)>
        var callLogin: Driver<(email: String, pass: String)>
        var toRegister: Driver<Void>
        var toHomeTrigger: Driver<Void>
    }
    
    struct Output {
        var validateForm: Driver<Bool>
        var callLogin: Driver<Token>
        var toRegister: Driver<Void>
        var toHome: Driver<Void>
        let error: Driver<Error>
    }
    
    func transform(_ input: Input) -> Output {
        let errorTracker = ErrorTracker()
        let isValidateForm = input.validateForm
            .flatMap { arg -> Driver<Bool> in
                return self.useCase
                    .validateForm(email: arg.email, pass: arg.pass)
                    .asDriverOnErrorJustComplete()
        }
        
        let callLogin = input.callLogin
            .flatMap { arg -> Driver<Token> in
            self.useCase
                .callLogin(email: arg.email, pass: arg.pass)
                .trackError(errorTracker)
                .asDriverOnErrorJustComplete()
        }
        
        let toRegister = input.toRegister.do(onNext: { _ in
            self.navigator.toRegister()
        }).mapToVoid()
        
        let toHome = input.toHomeTrigger.do(onNext: { _ in
            self.navigator.toHome()
        }).mapToVoid()
        
        return Output(validateForm: isValidateForm,
                      callLogin: callLogin,
                      toRegister: toRegister,
                      toHome: toHome,
                      error: errorTracker.asDriver())
    }
}
