//  Spicc
//
//  Created by nhatnt on 7/9/19.
//  Copyright © 2019 ntn.fastdev.vn. All rights reserved.
//

import ObjectMapper
import RxCocoa
import RxSwift
import SwiftyJSON

protocol AuthAPIProtocol {
    func login(_ input: API.LoginInput) -> Observable<API.LoginOutput>
}

extension API: AuthAPIProtocol {
    func login(_ input: API.LoginInput) -> Observable<API.LoginOutput> {
        return request(input)
    }
}

// MARK: - Get Login
extension API {
    
    final class LoginInput: APIInput {
        init(email: String, pass: String) {
            
            let params: [String: Any] = [
                "email": email,
                "password": pass
            ]
            super.init(urlString: API.Urls.login,
                       parameters: params,
                       requestType: .post,
                       requireAccessToken: false)
        }
    }
    
    final class LoginOutput: APIOutput {
        private(set) var token: Token?
        private(set) var errorMessage: String?
        
        override func mapping(map: Map) {
            super.mapping(map: map)
            token <- map["data"]
            errorMessage <- map["meta.message"]
        }
    }
}

