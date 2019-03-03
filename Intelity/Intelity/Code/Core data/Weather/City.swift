//
//  City.swift
//  Intelity
//
//  Created by Mikael on 3/3/19.
//  Copyright © 2019 Mikael-Melkonyan. All rights reserved.
//

import Foundation
import CoreData

@objc(City)
final class City: NSManagedObject {
    
    @NSManaged var name: String?
    @NSManaged var countryCode: String?
    @NSManaged var weather: Weather?
    
}

// MARK: Class functions
extension City {
    
    private static var entityName: String {
        return "City"
    }
    
    class func request() -> NSFetchRequest<City> {
        return NSFetchRequest<City>(entityName: entityName)
    }
    
    class func entity(in context: NSManagedObjectContext) -> NSEntityDescription {
        return NSEntityDescription.entity(forEntityName: entityName, in: context)!
    }
}
