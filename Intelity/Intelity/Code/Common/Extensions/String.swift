//
//  String.swift
//  Intelity
//
//  Created by Mikael on 3/3/19.
//  Copyright © 2019 Mikael-Melkonyan. All rights reserved.
//

extension String {
    
    var capitalizedFirstLetter: String {
        return prefix(1).uppercased() + lowercased().dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = capitalizedFirstLetter
    }
}
