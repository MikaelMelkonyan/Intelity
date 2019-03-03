//
//  Weather.swift
//  Intelity
//
//  Created by Mikael on 3/2/19.
//  Copyright © 2019 Mikael-Melkonyan. All rights reserved.
//

import SwiftyJSON

struct Weather {
    
    let id: String
    let city: City
    let temperature: Double
    let values: [(icon: String, description: String)]
    let date: Date
    
    init(json: JSON) {
        id = json["id"].stringValue
        let cityName = json["name"].stringValue
        let countryCode = json["sys"]["country"].stringValue
        city = City(name: cityName, country: Country(code: countryCode))
        temperature = json["main"]["temp"].doubleValue
        values = json["weather"].arrayValue.map {
            (icon: $0["icon"].stringValue, description: $0["description"].stringValue)
        }
        date = Date(timeIntervalSince1970: json["dt"].doubleValue)
    }
}
