//
//  HomeUseCase.swift
//  Spicc
//
//  Created by nhatnt on 7/9/19.
//  Copyright © 2019 ntn.fastdev.vn. All rights reserved.
//

import Foundation

extension API {
    struct Urls {
        static var domainURL: String = "http://52.199.104.196"
        static var midUrl: String = "/api/v1"
        static var login: String { return domainURL + midUrl + "/auth/login" }
    }
}
