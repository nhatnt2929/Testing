//
//  LoginAssembler.swift
//  MockingProject
//
//  Created by nhatnt on 7/1/20.
//  Copyright © 2020 eplus.epfs.ios. All rights reserved.
//

import Foundation
import UIKit


protocol Assembler: class,
    LoginAssembler,
    RepositoriesAssembler {
}

class DefaultAssembler: Assembler {
    static let shared = DefaultAssembler()
}

protocol LoginAssembler {
    func resolvedLoginVC(navi: UINavigationController) -> LoginViewController
    func resolvedLoginVM(navi: UINavigationController) -> LoginViewModel
    func resolvedLoginNavigator(navi: UINavigationController) -> LoginNavigatorProtocol
    func resolvedLoginUseCase() -> LoginUseCaseProtocol
}

extension LoginAssembler {
    func resolvedLoginVC(navi: UINavigationController) -> LoginViewController {
        let vc = LoginViewController.instantiate()
        let vm: LoginViewModel = resolvedLoginVM(navi: navi)
        vc.bindViewModel(to: vm)
        return vc
    }
    
    func resolvedLoginVM(navi: UINavigationController) -> LoginViewModel {
        return LoginViewModel(useCase: resolvedLoginUseCase(),
                              navigator: resolvedLoginNavigator(navi: navi))
    }
    
    func resolvedLoginNavigator(navi: UINavigationController) -> LoginNavigatorProtocol {
        return LoginNavigator(navi: navi)
    }
}

extension LoginAssembler where Self: DefaultAssembler {
    func resolvedLoginUseCase() -> LoginUseCaseProtocol {
        return LoginUseCase(repo: resolve())
    }
}
