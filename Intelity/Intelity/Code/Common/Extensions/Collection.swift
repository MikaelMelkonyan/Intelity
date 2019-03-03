//
//  Collection.swift
//  Intelity
//
//  Created by Mikael on 3/3/19.
//  Copyright © 2019 Mikael-Melkonyan. All rights reserved.
//

extension Collection {
    
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
