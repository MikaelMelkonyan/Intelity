//
//  WeatherViewModel.swift
//  Intelity
//
//  Created by Mikael on 3/2/19.
//  Copyright © 2019 Mikael-Melkonyan. All rights reserved.
//

final class WeatherViewModel {
    
    private unowned var view: WeatherView
    init(view: WeatherView) {
        self.view = view
    }
    
    private let api = WeatherApi()
    
    var properties: ResponseState<[Weather]> = .loading {
        didSet {
            main {
                self.view.update()
            }
        }
    }
    
    private let cityIDs = [
        "Kyiv": "703448",
        "Toronto": "6167865",
        "London": "2643741"
    ]
}

// MARK: Public
extension WeatherViewModel {
    
    func updateWeatherData() {
        properties = .loading
        background {
            let cityIDs = self.cityIDs.map { $1 }
            self.api.getWeather(by: cityIDs) { [weak self] in
                guard let _self = self else {
                    return
                }
                
                switch $0 {
                case let .success(list):
                    if !list.isEmpty {
                        _self.properties = .success(list)
                    } else {
                        _self.properties = .message("Weather list is empty")
                    }
                case let .error(text):
                    _self.properties = .message(text)
                }
            }
        }
    }
}
