//
//  TrendingNavigatorMock.swift
//  AkiTravelUnitTest
//
//  Created by nhatnt on 7/3/20.
//  Copyright © 2020 Aki Travel. All rights reserved.
//

@testable import MockingProject
import Foundation
import UIKit

final class LoginNavigatorMock: LoginNavigatorProtocol {
    
    var toHomeVc_called = false
    func toHome() {
        toHomeVc_called = true
    }
    
    var toRegisterVc_called = false
    func toRegister() {
        toRegisterVc_called = true
    }
}
