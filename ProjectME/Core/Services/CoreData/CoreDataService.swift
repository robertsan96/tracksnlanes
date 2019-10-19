//
//  CoreDataService.swift
//  ProjectME
//
//  Created by Robert Sandru on 10/19/19.
//  Copyright © 2019 codecontrive. All rights reserved.
//

import UIKit
import CoreData

class CoreDataService {
    
    static var shared: CoreDataService = try! CoreDataService()
    
    enum CoreDataServiceError: Error {
        case couldNotGetContext
    }
    
    var context: NSManagedObjectContext
    
    private init() throws {
        guard let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext else {
            throw CoreDataServiceError.couldNotGetContext
        }
        self.context = context
    }
    
    func get<T: NSManagedObject>() -> [T] {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: T.entityName)
        do {
            let objects = try context.fetch(fetchRequest) as? [T]
            return objects ?? []
        } catch {
            print("Something went wrong fetching \(T.entityName)s.")
            return []
        }
    }
    
    func store<T: NSManagedObject>(object: T) {
        do {
            try context.save()
        } catch {
            print("Something went wrong saving \(object.entity).")
        }
    }
}
