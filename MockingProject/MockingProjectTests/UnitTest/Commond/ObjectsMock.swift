//
//  CollectionMock.swift
//  AkiTravelUnitTest
//
//  Created by nhatnt on 7/3/20.
//  Copyright © 2020 Aki Travel. All rights reserved.
//

import Foundation
@testable import MockingProject
import UIKit

extension Token: MockAble {
  static func mock() -> Token {
    return Token(accessToken: String.random(), refreshToken: String.random())
  }
}
