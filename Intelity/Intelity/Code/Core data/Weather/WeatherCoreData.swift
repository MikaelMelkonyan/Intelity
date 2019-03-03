//
//  WeatherCoreData.swift
//  Intelity
//
//  Created by Mikael on 3/3/19.
//  Copyright © 2019 Mikael-Melkonyan. All rights reserved.
//

import CoreData
import SwiftyJSON

final class WeatherCoreData {
    
    func getList() -> [Weather] {
        let request = Weather.request()
        request.returnsObjectsAsFaults = false
        do {
            let result = try CoreData.shared.context.fetch(request)
            return result
        } catch(let error) {
            print("Unresolved error \(error), \(error.localizedDescription)")
            return []
        }
    }
    
    func getWeather(from json: JSON) -> Weather {
        let request = Weather.request()
        let id = json["id"].stringValue
        request.predicate = NSPredicate(format: "id == %@", id)
        
        do {
            let result = try CoreData.shared.context.fetch(request)
            if let weather = result.first {
                weather.change(by: json)
                return weather
            } else {
                return createWeather(from: json)
            }
        } catch(let error) {
            print("Unresolved error \(error), \(error.localizedDescription)")
            return createWeather(from: json)
        }
    }
    
    private func createWeather(from json: JSON) -> Weather {
        let entity = Weather.entity(in: CoreData.shared.context)
        let weather = NSManagedObject(entity: entity, insertInto: CoreData.shared.context) as! Weather
        weather.change(by: json)
        return weather
    }
}
