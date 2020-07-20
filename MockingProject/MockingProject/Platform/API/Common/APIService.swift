//
//  HomeUseCase.swift
//  Spicc
//
//  Created by nhatnt on 7/9/19.
//  Copyright © 2019 ntn.fastdev.vn. All rights reserved.
//

import ObjectMapper
import Alamofire
import RxSwift
import RxAlamofire

final class API {
    static let shared = API()
    
    func request<T: Mappable>(_ input: APIInputBase) -> Observable<T> {
        return request(input).map { json -> T in
            if let t = T(JSON: json) {
                return t
            }
            throw APIOutput.toError(message: "invalid response data!")
        }
    }
}

// MARK: - Support methods
extension API {
    fileprivate func request(_ input: APIInputBase) -> Observable<JSONDictionary> {
        let urlRequest = preprocess(input)
            .do(onNext: { input in
                print(input)
            })
            .flatMapLatest { input in
                Alamofire.SessionManager.default.rx
                    .request(input.requestType,
                             input.urlString,
                             parameters: input.parameters,
                             encoding: input.encoding,
                             headers: input.headers)
            }
            .flatMapLatest { dataRequest -> Observable<(HTTPURLResponse, Data)> in
                return dataRequest.rx.responseData()
            }
            .map { (dataResponse) -> JSONDictionary in
                return try self.process(dataResponse)
            }
            .catchError({ error -> Observable<[String : Any]> in
                throw error
            })
        
        return urlRequest
    }
    
    fileprivate func process(_ response: (HTTPURLResponse, Data)) throws -> JSONDictionary {
        let (response, data) = response
        let json: JSONDictionary? = (try? JSONSerialization.jsonObject(with: data, options: [])) as? JSONDictionary
        var error: Error
        switch response.statusCode {
        case 200..<300:
            print("👍 [\(response.statusCode)] " + (response.url?.absoluteString ?? ""))
            return json ?? JSONDictionary()
        default:
            if let json = json, let responseError = ResponseError(JSON: json) {
                error = responseError.toError()
            } else {
                error = NSError(domain:"", code: 400, userInfo: [NSLocalizedDescriptionKey: "messsage" as Any]) as Error
            }
            print("❌ [\(response.statusCode)] " + (response.url?.absoluteString ?? ""))
            if let json = json {
                print(json)
            }
        }
        throw error
    }
    
    fileprivate func preprocess(_ input: APIInputBase) -> Observable<APIInputBase> {
        return Observable.deferred {
            return Observable.just(input)
        }
    }
}

extension Error {
    var code: Int { return (self as NSError).code }
    var domain: String { return (self as NSError).domain }
}
