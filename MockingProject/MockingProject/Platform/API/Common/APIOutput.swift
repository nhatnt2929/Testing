//
//  HomeUseCase.swift
//  Spicc
//
//  Created by nhatnt on 7/9/19.
//  Copyright © 2019 ntn.fastdev.vn. All rights reserved.
//

import ObjectMapper

class APIOutput: APIOutputBase {
    private(set) var code: Int!
    private(set) var field: ErrorField!
    private(set) var message: String!
    
    override func mapping(map: Map) {
        code <- map["meta.status"]
        field <- map["errors.errors"]
        message <- map["meta.message"]
    }
    
    func toError() -> Error {
        return NSError(domain:"", code: self.code, userInfo:[ NSLocalizedDescriptionKey: self.message as Any]) as Error
    }
    
    static func toError(code: Int, message: String) -> Error {
        return NSError(domain:"", code: code, userInfo:[ NSLocalizedDescriptionKey: message as Any]) as Error
    }
    
    static func toError(message: String) -> Error {
        return NSError(domain:"", code: 0, userInfo:[ NSLocalizedDescriptionKey: message as Any]) as Error
    }
}

enum ErrorField: String {
    case others
}
