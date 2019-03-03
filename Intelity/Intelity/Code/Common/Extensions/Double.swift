//
//  Double.swift
//  Intelity
//
//  Created by Mikael on 3/3/19.
//  Copyright © 2019 Mikael-Melkonyan. All rights reserved.
//

import Foundation

extension Double {
    
    func rounded(to places: Int) -> Double {
        let divisor = pow(10, Double(places))
        return (divisor * self).rounded() / divisor
    }
    
    mutating func round(to places: Int) {
        let divisor = pow(10, Double(places))
        self = (divisor * self).rounded() / divisor
    }
}
