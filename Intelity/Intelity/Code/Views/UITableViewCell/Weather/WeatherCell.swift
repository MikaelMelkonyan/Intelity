//
//  WeatherCell.swift
//  Intelity
//
//  Created by Mikael on 3/3/19.
//  Copyright © 2019 Mikael-Melkonyan. All rights reserved.
//

import UIKit

final class WeatherCell: SimpleCell {
    
    @IBOutlet weak private var icon: UIImageView!
    @IBOutlet weak private var location: UILabel!
    @IBOutlet weak private var weather: UILabel!
    @IBOutlet weak private var temperature: UILabel!
    
    func fill(weather: Weather, row: Int) {
        var locationData = [String]()
        if let city = weather.city {
            if let cityName = city.name {
                locationData.append(cityName)
            }
            if let countryCode = city.countryCode {
                locationData.append(countryCode.uppercased())
            }
        }
        location.text = locationData.joined(separator: ", ")
        
        self.weather.text = weather.types?
            .compactMap { $0.name?.capitalizedFirstLetter }
            .sorted()
            .joined(separator: ", ")
        temperature.text = String(format: "%.0f", weather.temperature.rounded(to: 0)) + "°"
        
        icon.image = nil
        if let type = weather.types?.first, let iconName = type.iconName {
            ImageLoader.load(by: iconName, index: row) { [weak self] (name, _row, image) in
                if let image = image, row == _row {
                    self?.icon.image = image
                }
            }
        }
    }
}
