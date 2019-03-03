//
//  WeatherView.swift
//  Intelity
//
//  Created by Mikael on 3/2/19.
//  Copyright © 2019 Mikael-Melkonyan. All rights reserved.
//

protocol WeatherView: AnyObject {
    
    func update()
    func changeOfflineModePopup(showing: Bool, lastDate: String?)
}
