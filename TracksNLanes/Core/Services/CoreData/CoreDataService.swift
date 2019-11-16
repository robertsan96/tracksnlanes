//
//  CoreDataService.swift
//  TracksNLanes
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
        
        let pl1 = LaneModel(context: context)
        pl1.name = "Weight Lane"
        pl1.descriptionShort = "A lane that will register your weight and will remind you periodically to renew the input values. It will also generate a graph with all the progress or regress you made. It is benefic to be added into a Healthy Life tracker. 😎"
        pl1.descriptionLong = "This lane is all about logging your water consumption. It will generate graphs, show you progress and it's able to send notifications."
        pl1.createdAt = Date.getDateInTimezone()
        pl1.updatedAt = Date.getDateInTimezone()
        pl1.system = true
        pl1.premium = true
        pl1.locked = false
        pl1.unitSystemIdentifier = UnitSystemIdentifier.kilogram.rawValue
        
        let pl2 = LaneModel(context: context)
        pl2.name = "Running Lane 🏃🏻‍♂️"
        pl2.descriptionShort = "Are you ready for the marathon? Log all your running distances using this awesome predefined Jogging Lane. Charts, notifications are mandatory for a runner to improve. We know that, that's why we included all this functionality in this premium lane."
        pl2.descriptionLong = "This lane is all about logging your water consumption. It will generate graphs, show you progress and it's able to send notifications."
        pl2.createdAt = Date.getDateInTimezone()
        pl2.updatedAt = Date.getDateInTimezone()
        pl2.system = true
        pl2.premium = true
        pl2.locked = true
        pl2.unitSystemIdentifier = UnitSystemIdentifier.kilometer.rawValue
        
        let pl3 = LaneModel(context: context)
        pl3.name = "Menstrual Cycles Lane"
        pl3.descriptionShort = "Ugh.. it's been already a month! 🙍🏻‍♀️ We got you covered, girls! Log all your menstrual cycle activity in this lane and we promise you'll never be surprised again by your body. We use predictions and machine learning to cover you. All for free."
        pl3.descriptionLong = "This lane is all about logging your water consumption. It will generate graphs, show you progress and it's able to send notifications."
        pl3.createdAt = Date.getDateInTimezone()
        pl3.updatedAt = Date.getDateInTimezone()
        pl3.system = true
        pl3.premium = false
        pl3.locked = false
        pl3.unitSystemIdentifier = UnitSystemIdentifier.hour.rawValue
        
        let pl4 = LaneModel(context: context)
        pl4.name = "Water Lane 💦"
        pl4.descriptionShort = "Did you drink your water? Include this lane in your healthy tracker and you'll be able to count the quantity of water you want to consume per day. Just configure the quantity and the notifications interval. We'll take care of the rest. You just drink."
        pl4.descriptionLong = "This lane is all about logging your water consumption. It will generate graphs, show you progress and it's able to send notifications."
        pl4.createdAt = Date.getDateInTimezone()
        pl4.updatedAt = Date.getDateInTimezone()
        pl4.system = true
        pl4.premium = false
        pl4.locked = false
        pl4.unitSystemIdentifier = UnitSystemIdentifier.milimeter.rawValue
        
        let pl5 = LaneModel(context: context)
        pl5.name = "Belly Size Lane"
        pl5.descriptionShort = "So you want to get fit? Why not keep an eye on your centimeters? Make sure you measure your beer belly and insert the values in this lane. We'll show you how it's growing! Oops, how it's getting smaller! 😎"
        pl5.descriptionLong = "This lane is all about logging your water consumption. It will generate graphs, show you progress and it's able to send notifications."
        pl5.createdAt = Date.getDateInTimezone()
        pl5.updatedAt = Date.getDateInTimezone()
        pl5.system = true
        pl5.premium = false
        pl5.locked = false
        pl5.unitSystemIdentifier = UnitSystemIdentifier.centimeter.rawValue
        
        store(object: weightLossTrack)
        store(object: pl1)
    }
}
