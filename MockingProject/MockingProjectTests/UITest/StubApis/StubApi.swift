//
//  StubApi.swift
//  AkiTravelUITests
//
//  Created by nhatnt on 7/6/20.
//  Copyright © 2020 Aki Travel. All rights reserved.
//

@testable import MockingProject
import Mockingjay
import KIF

extension XCTest {
    func getJsonStubOfFile(_ fileName: String?) -> NSData {
        let path = Bundle(for: type(of: self)).path(forResource: fileName, ofType: "json")!
        return NSData(contentsOfFile: path)!
    }
}

extension XCTestCase {
    func stub_login_success() {
        let data = getJsonStubOfFile("login_success")
        stub(http(.post, uri: API.Urls.login), jsonData(data as Data))
    }
    
    func stub_login_failed() {
        let data = getJsonStubOfFile("login_failed")
        stub(http(.post, uri: API.Urls.login), jsonData(data as Data))
    }
}
