//
//  WeatherType+CoreDataClass.swift
//  Intelity
//
//  Created by Mikael on 3/3/19.
//  Copyright © 2019 Mikael-Melkonyan. All rights reserved.
//
//

import Foundation
import CoreData

@objc(WeatherType)
final class WeatherType: NSManagedObject {
    
    @NSManaged var id: Int64
    @NSManaged var iconName: String?
    @NSManaged var icon: Data?
    @NSManaged var name: String?
    @NSManaged var weather: Weather?
    
}

// MARK: Class functions
extension WeatherType {
    
    private static var entityName: String {
        return "WeatherType"
    }
    
    class func request() -> NSFetchRequest<WeatherType> {
        return NSFetchRequest<WeatherType>(entityName: entityName)
    }
    
    class func entity(in context: NSManagedObjectContext) -> NSEntityDescription {
        return NSEntityDescription.entity(forEntityName: entityName, in: context)!
    }
}
