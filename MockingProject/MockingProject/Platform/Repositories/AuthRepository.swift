//
//  AuthRepository.swift
//  Spicc
//
//  Created by nhatnt on 7/9/19.
//  Copyright © 2019 ntn.fastdev.vn. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol UserRepositoryProtocol {
    func callLogin(email: String, pass: String) -> Observable<Token>
    func validateForm(email: String, pass: String) -> Observable<Bool>
}


final class UserRepository: UserRepositoryProtocol {
    
    func callLogin(email: String, pass: String) -> Observable<Token> {
        let input = API.LoginInput(email: email, pass: pass)
        return API.shared.login(input).map { output -> Token in
            guard let token = output.token else {
                throw APIOutput.toError(message: output.errorMessage ?? "invalid data")
            }
            return token
        }
    }
    
    func validateForm(email: String, pass: String) -> Observable<Bool> {
        let emailRegEx = Validations.regexEmail
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return Observable.just(emailPred.evaluate(with: email) && pass.count > 3)
    }
}
