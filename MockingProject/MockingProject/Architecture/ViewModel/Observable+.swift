//
//  Observable+.swift
//  MockingProject
//
//  Created by nhatnt on 7/1/20.
//  Copyright © 2020 eplus.epfs.ios. All rights reserved.
//
import Foundation
import RxSwift
import RxCocoa

extension SharedSequenceConvertibleType {
    func mapToVoid() -> SharedSequence<SharingStrategy, Void> {
        return map { _ in }
    }
}

extension ObservableType {
    func asDriverOnErrorJustComplete() -> Driver<Element> {
        return asDriver { _ in
            return Driver.empty()
        }
    }
}
