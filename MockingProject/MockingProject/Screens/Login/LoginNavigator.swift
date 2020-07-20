//
//  LoginNavigator.swift
//  MockingProject
//
//  Created by nhatnt on 7/1/20.
//  Copyright © 2020 eplus.epfs.ios. All rights reserved.
//

import Foundation
import UIKit

protocol LoginNavigatorProtocol {
    func toHome()
    func toRegister()
}

struct LoginNavigator: LoginNavigatorProtocol {
    let navi: UINavigationController
    
    func toHome() {
        let vc: HomeViewController = HomeViewController.instantiate()
        navi.pushViewController(vc, animated: true)
    }
    
    func toRegister() {
        let vc = RegisterViewController.instantiate()
        navi.pushViewController(vc, animated: true)
    }
}
