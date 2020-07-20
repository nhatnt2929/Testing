//  Spicc
//
//  Created by nhatnt on 7/9/19.
//  Copyright © 2019 ntn.fastdev.vn. All rights reserved.
//

import Alamofire
import Then

typealias JSONDictionary = [String: Any]

class APIInputBase: Then {
    var headers: [String: String] = [:]
    let urlString: String
    let requestType: HTTPMethod
    let encoding: ParameterEncoding
    let parameters: [String: Any]?
    let requireAccessToken: Bool
    var accessToken: String?
    
    init(urlString: String,
         parameters: [String: Any]?,
         requestType: HTTPMethod,
         requireAccessToken: Bool) {
        self.urlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? urlString
        self.parameters = parameters
        self.requestType = requestType
        self.encoding = requestType == .get ? URLEncoding.default : JSONEncoding.default
        self.requireAccessToken = requireAccessToken
    }
}
