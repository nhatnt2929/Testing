//
//  ViewModelType.swift
//  MockingProject
//
//  Created by nhatnt on 7/1/20.
//  Copyright © 2020 eplus.epfs.ios. All rights reserved.
//

import Foundation

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(_ input: Input) -> Output
}
