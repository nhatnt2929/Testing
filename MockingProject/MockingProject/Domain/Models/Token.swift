//
//  Token.swift
//  MockingProject
//
//  Created by nhatnt on 7/10/20.
//  Copyright © 2020 eplus.epfs.ios. All rights reserved.
//

import Foundation
import ObjectMapper

struct Token: Codable {
    public var accessToken: String
    public var refreshToken: String
    
    public init(accessToken: String = "",
                refreshToken: String = "") {
        self.accessToken = accessToken
        self.refreshToken = refreshToken
    }
}

extension Token: Mappable {
    public init?(map: Map) {
        self.init()
        mapping(map: map)
    }
    
    public mutating func mapping(map: Map) {
        accessToken <- map[Keys.accessToken]
        refreshToken <- map[Keys.refreshToken]
    }
}

extension Token {
    public init() {
        self.init(accessToken: "",
                  refreshToken: "")
    }
    
    struct Keys {
        static let accessToken = "access_token"
        static let refreshToken = "refreshToken"
    }
}
