//
//  HomeUseCase.swift
//  Spicc
//
//  Created by nhatnt on 7/9/19.
//  Copyright © 2019 ntn.fastdev.vn. All rights reserved.
//

import Alamofire

struct Header {
    static let contentTypeKey = "Content-Type"
    static let contentTypeValue = "application/json; charset=utf-8"
    
    static let acceptKey = "Accept"
    static let acceptValue = "application/json"
    
    static let secretKey = "Secret"
    static let secretValue = ""
    
}

class APIInput: APIInputBase {
    override init(urlString: String, parameters: [String : Any]?,
                  requestType: HTTPMethod, requireAccessToken: Bool) {
        super.init(urlString: urlString,
                   parameters: parameters,
                   requestType: requestType,
                   requireAccessToken: requireAccessToken)
        self.headers = [
            Header.contentTypeKey: Header.contentTypeValue,
            Header.acceptKey: Header.acceptValue,
            Header.secretKey: Header.secretValue
        ]
    }
}
