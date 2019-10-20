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
//        migrate()
    }
    
    func get<T: NSManagedObject>(orderedByUpdateDate: Bool = true) -> [T] {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: T.entityName)
        if orderedByUpdateDate {
            let sortDescriptor = NSSortDescriptor(key: "updatedAt", ascending: false)
            fetchRequest.sortDescriptors = [sortDescriptor]
        }
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
    
    func remove<T: NSManagedObject>(object: T) {
        context.delete(object)
        do {
            try context.save()
        } catch {
            print("Something went wrong deleting \(object.entity).")
        }
    }
}

extension CoreDataService {
    
    func migrate() {
        let weightLossTrack = TrackModel(context: context)
        weightLossTrack.name = "Weight Loss"
        weightLossTrack.createdAt = Date.getDateInTimezone()
        weightLossTrack.updatedAt = Date.getDateInTimezone()
        weightLossTrack.system = true
        
        let weightLossKgLane = LaneModel(context: context)
        weightLossKgLane.name = "Kilogram Lane"
        weightLossKgLane.descriptionShort = "A lane that will register kilograms."
        weightLossKgLane.descriptionLong = "This lane is all about logging your weight. It will generate graphs, show you progress and it's able to send notifications."
        weightLossKgLane.createdAt = Date.getDateInTimezone()
        weightLossKgLane.updatedAt = Date.getDateInTimezone()
        weightLossKgLane.system = true
        
        weightLossTrack.addToLanes(weightLossKgLane)
        
        store(object: weightLossTrack)
        
        let waterConsumptionLane = LaneModel(context: context)
        waterConsumptionLane.name = "Water Lane"
        waterConsumptionLane.descriptionShort = "A lane that will register water consumption."
        waterConsumptionLane.descriptionLong = "This lane is all about logging your water consumption. It will generate graphs, show you progress and it's able to send notifications."
        waterConsumptionLane.createdAt = Date.getDateInTimezone()
        waterConsumptionLane.updatedAt = Date.getDateInTimezone()
        waterConsumptionLane.system = true
        
        store(object: waterConsumptionLane)
        
        let chestSizeLane = LaneModel(context: context)
        chestSizeLane.name = "Chest Size Lane"
        chestSizeLane.descriptionShort = "A lane that will register your chest size."
        chestSizeLane.descriptionLong = "This lane is all about logging your chest size. It will generate graphs, show you progress and it's able to send notifications."
        chestSizeLane.createdAt = Date.getDateInTimezone()
        chestSizeLane.updatedAt = Date.getDateInTimezone()
        chestSizeLane.system = true
        
        store(object: chestSizeLane)
        
        let seatSizeLane = LaneModel(context: context)
        seatSizeLane.name = "Seat Size Lane"
        seatSizeLane.descriptionShort = "A lane that will register your big ass size."
        seatSizeLane.descriptionLong = "This lane is all about logging your big ass size. It will generate graphs, show you progress and it's able to send notifications."
        seatSizeLane.createdAt = Date.getDateInTimezone()
        seatSizeLane.updatedAt = Date.getDateInTimezone()
        seatSizeLane.system = true
        
        store(object: seatSizeLane)
    }
}
