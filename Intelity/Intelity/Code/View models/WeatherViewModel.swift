//
//  WeatherViewModel.swift
//  Intelity
//
//  Created by Mikael on 3/2/19.
//  Copyright © 2019 Mikael-Melkonyan. All rights reserved.
//

final class WeatherViewModel {
    
    private unowned var view: WeatherView
    
    private let api = WeatherApi()
    private let coreData = WeatherCoreData()
    private let reachability = Reachability()!
    private let cityIDs = ["Kyiv": "703448", "Toronto": "6167865", "London": "2643741"]
    
    var properties: ResponseState<[Weather]> = .loading {
        didSet {
            if case let .success(list) = properties {
                properties = .success(list.sorted(by: { ($0.id ?? "") > ($1.id ?? "") }))
            }
            main {
                self.view.update()
            }
        }
    }
    
    init(view: WeatherView) {
        self.view = view
        reachability.whenReachable = { [weak self] (reachability) in
            self?.checkReachability()
            if reachability.connection != .none {
                self?.updateWeatherData()
            }
        }
        reachability.whenUnreachable = { [weak self] (reachability) in
            self?.checkReachability()
        }
    }
    
    deinit {
        reachability.stopNotifier()
    }
}

// MARK: Public
extension WeatherViewModel {
    
    func updateWeatherData() {
        properties = .loading
        guard reachability.connection != .none else {
            let list = coreData.getList()
            properties = !list.isEmpty ? .success(list) : .message("Weather list is empty")
            return
        }
        
        background {
            let cityIDs = self.cityIDs.map { $1 }
            self.api.getWeather(by: cityIDs) { [weak self] in
                guard let _self = self else {
                    return
                }
                
                switch $0 {
                case let .success(jsonList):
                    if !jsonList.isEmpty {
                        let list = jsonList.compactMap { self?.coreData.getWeather(from: $0) }
                        CoreData.shared.saveContext()
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
    
    func startReachabilityNotifier() {
        try? reachability.startNotifier()
    }
    
    func stopReachabilityNotifier() {
        reachability.stopNotifier()
    }
    
    func checkReachability() {
        background {
            var lastDate: String?
            if case let .success(list) = self.properties, let date = list.first?.date {
                lastDate = date.dateAndTime
            }
            main {
                self.view.changeOfflineModePopup(showing: self.reachability.connection == .none, lastDate: lastDate)
            }
        }
    }
}
