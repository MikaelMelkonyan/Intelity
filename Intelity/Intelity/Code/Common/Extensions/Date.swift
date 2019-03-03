//
//  Date.swift
//  Intelity
//
//  Created by Mikael on 3/3/19.
//  Copyright © 2019 Mikael-Melkonyan. All rights reserved.
//

import Foundation

extension Date {
    
    private var isToday: Bool {
        get {
            return Calendar.current.isDateInToday(self)
        }
    }
    
    private var isYesterday: Bool {
        get {
            return Calendar.current.isDateInYesterday(self)
        }
    }
    
    var dateAndTime: String {
        get {
            let dateFormatter = DateFormatter()
            if isToday {
                dateFormatter.dateFormat = "HH:mm"
                return "today at " + dateFormatter.string(from: self)
            } else if isYesterday {
                dateFormatter.dateFormat = "HH:mm"
                return "yesterday at " + dateFormatter.string(from: self)
            } else {
                dateFormatter.dateFormat = "dd.MM.yyyy at HH:mm"
            }
            return dateFormatter.string(from: self)
        }
    }
}
