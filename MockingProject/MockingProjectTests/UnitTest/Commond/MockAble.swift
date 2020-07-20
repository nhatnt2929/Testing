//
//  MockAble.swift
//  AkiTravelUnitTest
//
//  Created by nhatnt on 7/3/20.
//  Copyright © 2020 Aki Travel. All rights reserved.
//

import Foundation
@testable import MockingProject
import RxSwift

protocol MockAble {
    static func mock() -> Self
}
class MockRepository<T: MockAble & Equatable> {
    var objects: [T] = []
    
    func get() -> Observable<[T]> {
        objects = (0..<10).map { _ in T.mock() }
        return Observable.just(objects)
    }
    
    func getMore() -> Observable<[T]> {
        let more = (0..<10).map { _ in T.mock() }
        objects += more
        return Observable.just(more)
    }
}
