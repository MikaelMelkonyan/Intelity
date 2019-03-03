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
        location.text = "\(weather.city.name.capitalized), \(weather.city.country.code.uppercased())"
        self.weather.text = weather.values
            .map { $1.capitalizedFirstLetter }
            .joined(separator: ", ")
        temperature.text = String(format: "%.0f", weather.temperature.rounded(to: 0)) + "°"
        
        icon.image = nil
        if let value = weather.values.first {
            ImageLoader.load(by: value.icon, index: row) { [weak self] (name, _row, image) in
                if let image = image, row == _row {
                    self?.icon.image = image
                }
            }
        }
    }
}
