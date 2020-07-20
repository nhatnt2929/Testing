//
//  RepositoriesAssembler.swift
//  Spicc
//
//  Created by nhatnt on 7/9/19.
//  Copyright © 2019 ntn.fastdev.vn. All rights reserved.
//

protocol RepositoriesAssembler {
    func resolve() -> UserRepositoryProtocol
}

extension RepositoriesAssembler where Self: DefaultAssembler {
    func resolve() -> UserRepositoryProtocol {
        return UserRepository()
    }
}
