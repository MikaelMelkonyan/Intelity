//
//  CoreData.swift
//  Intelity
//
//  Created by Mikael on 3/3/19.
//  Copyright © 2019 Mikael-Melkonyan. All rights reserved.
//

import CoreData

final class CoreData {
    
    static let shared = CoreData()
    private init() {}
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Intelity")
        container.loadPersistentStores(completionHandler: { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func saveContext(completion: ((Bool, String?) -> ())? = nil) {
        guard context.hasChanges else {
            completion?(true, nil)
            return
        }
        
        do {
            try context.save()
            completion?(true, nil)
        } catch(let error) {
            completion?(false, "Failed to save the database. Please try again")
            fatalError("Unresolved error \(error), \(error.localizedDescription)")
        }
    }
}
