//
//  Api.swift
//  Intelity
//
//  Created by Mikael on 3/2/19.
//  Copyright © 2019 Mikael-Melkonyan. All rights reserved.
//

class Api {
    
    let globalUrl = "https://api.openweathermap.org/data/2.5/"
    let units = "metric"
    let apiKey = "a1d1dc41d71e2b1c1d329e64770bf088"
    let somethingWentWrongMessage = "Oh no. Something went wrong. Please try again"
    static let imageUrl = "https://openweathermap.org/img/w/"
    
    enum Response<Success> {
        case success(Success)
        case error(String)
    }
}
