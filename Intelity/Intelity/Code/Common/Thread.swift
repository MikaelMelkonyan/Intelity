//
//  Thread.swift
//  Intelity
//
//  Created by Mikael on 3/2/19.
//  Copyright © 2019 Mikael-Melkonyan. All rights reserved.
//

import Foundation

func main(_ dispatch: @escaping (() -> ())) {
    DispatchQueue.main.async {
        dispatch()
    }
}

func background(_ dispatch: @escaping (() -> ())) {
    DispatchQueue.global(qos: .background).async {
        dispatch()
    }
}
