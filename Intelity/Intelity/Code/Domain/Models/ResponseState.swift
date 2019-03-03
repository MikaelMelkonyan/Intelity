//
//  ResponseState.swift
//  Intelity
//
//  Created by Mikael on 3/2/19.
//  Copyright © 2019 Mikael-Melkonyan. All rights reserved.
//

enum ResponseState<Success> {
    case loading
    case message(String)
    case success(Success)
}
