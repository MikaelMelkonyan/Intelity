//
//  Weather.swift
//  Intelity
//
//  Created by Mikael on 3/3/19.
//  Copyright © 2019 Mikael-Melkonyan. All rights reserved.
//

import Foundation
import CoreData
import SwiftyJSON

@objc(Weather)
final class Weather: NSManagedObject {
    
    @NSManaged var id: String?
    @NSManaged var temperature: Double
    @NSManaged var date: Date?
    @NSManaged var city: City?
    @NSManaged var types: Set<WeatherType>?
    
    func change(by json: JSON) {
        id = json["id"].stringValue
        temperature = json["main"]["temp"].doubleValue
        date = Date(timeIntervalSince1970: json["dt"].doubleValue)
        
        let cityEntity = City.entity(in: CoreData.shared.context)
        city = NSManagedObject(entity: cityEntity, insertInto: CoreData.shared.context) as? City
        city?.name = json["name"].stringValue
        city?.countryCode = json["sys"]["country"].stringValue
        city?.weather = self
        
        let typeEntity = WeatherType.entity(in: CoreData.shared.context)
        types?.removeAll()
        for data in json["weather"].arrayValue {
            let type = NSManagedObject(entity: typeEntity, insertInto: CoreData.shared.context) as! WeatherType
            type.id = data["id"].int64Value
            type.iconName = data["icon"].stringValue
            type.name = data["description"].stringValue
            type.weather = self
            addToTypes(type)
        }
    }
}

// MARK: Class functions
extension Weather {
    
    private static var entityName: String {
        return "Weather"
    }
    
    class func request() -> NSFetchRequest<Weather> {
        return NSFetchRequest<Weather>(entityName: entityName)
    }
    
    class func entity(in context: NSManagedObjectContext) -> NSEntityDescription {
        return NSEntityDescription.entity(forEntityName: entityName, in: context)!
    }
}

// MARK: Generated accessors for types
extension Weather {
    
    @objc(addTypesObject:)
    @NSManaged private func addToTypes(_ value: WeatherType)
    
    @objc(removeTypesObject:)
    @NSManaged private func removeFromTypes(_ value: WeatherType)
    
    @objc(addTypes:)
    @NSManaged private func addToTypes(_ values: NSSet)
    
    @objc(removeTypes:)
    @NSManaged private func removeFromTypes(_ values: NSSet)
}
