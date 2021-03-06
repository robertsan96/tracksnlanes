//
//  Constants.swift
//  TracksNLanes
//
//  Created by Robert Sandru on 10/20/19.
//  Copyright © 2019 codecontrive. All rights reserved.
//

import Foundation

enum UnitSystemIdentifier: String {
    case kilogram = "US_KILOGRAM"
    case pound = "US_POUND"
    case gram = "US_GRAM"
    
    case second = "US_SECOND"
    case minute = "US_MINUTE"
    case hour = "US_HOUR"
    
    case meter = "US_METER"
    case centimeter = "US_CENTIMETER"
    case milimeter = "US_MILIMETER"
    case kilometer = "US_KILOMETER"
    
    func getCategory() -> UnitSystemCategoryIdentifier {
        switch self {
        case .kilogram, .pound, .gram: return .mass
        case .second, .minute, .hour: return .time
        case .meter, .centimeter, .milimeter, .kilometer: return .length
        }
    }
    
    static func getUnitSystemIdentifier(for string: String?) -> UnitSystemIdentifier? {
        guard string != nil else { return nil }
        switch string {
            case UnitSystemIdentifier.kilogram.rawValue: return .kilogram
            case UnitSystemIdentifier.pound.rawValue: return .pound
            case UnitSystemIdentifier.gram.rawValue: return .gram
            
            case UnitSystemIdentifier.second.rawValue: return .second
            case UnitSystemIdentifier.minute.rawValue: return .minute
            case UnitSystemIdentifier.hour.rawValue: return .hour
            
            case UnitSystemIdentifier.meter.rawValue: return .meter
            case UnitSystemIdentifier.centimeter.rawValue: return .centimeter
            case UnitSystemIdentifier.milimeter.rawValue: return .milimeter
            case UnitSystemIdentifier.kilometer.rawValue: return .kilometer
        default: return nil
        }
    }
    
    static func getUnitSystemIdentifierByDescription(for description: String?) -> UnitSystemIdentifier? {
        guard description != nil else { return nil }
        switch description {
            case UnitSystemIdentifier.kilogram.getDescription(): return .kilogram
            case UnitSystemIdentifier.pound.getDescription(): return .pound
            case UnitSystemIdentifier.gram.getDescription(): return .gram
            
            case UnitSystemIdentifier.second.getDescription(): return .second
            case UnitSystemIdentifier.minute.getDescription(): return .minute
            case UnitSystemIdentifier.hour.getDescription(): return .hour
            
            case UnitSystemIdentifier.meter.getDescription(): return .meter
            case UnitSystemIdentifier.centimeter.getDescription(): return .centimeter
            case UnitSystemIdentifier.milimeter.getDescription(): return .milimeter
            case UnitSystemIdentifier.kilometer.getDescription(): return .kilometer
        default: return nil
        }
    }
    
    func getDescription() -> String {
        switch self {
        case .kilogram: return "Kilogram"
        case .pound: return "Pound"
        case .gram: return "Gram"
        
        case .second: return "Second"
        case .minute: return "Minute"
        case .hour: return "Hour"
        
        case .meter: return "Meter"
        case .centimeter: return "Centimeter"
        case .milimeter: return "Milimeter"
        case .kilometer: return "Kilometer"
        }
    }
}

enum UnitSystemCategoryIdentifier: String {
    
    case mass = "USC_MASS"
    case time = "USC_TIME"
    case length = "USC_LENGTH"
    
    static func getAll() -> [UnitSystemCategoryIdentifier] {
        return [.mass, .time, .length]
    }
    
    static func getUnitSystemCategoryIdentifier(for description: String?) -> UnitSystemCategoryIdentifier? {
        guard description != nil else { return nil }
        switch description {
        case UnitSystemCategoryIdentifier.mass.description(): return .mass
        case UnitSystemCategoryIdentifier.time.description(): return .time
        case UnitSystemCategoryIdentifier.length.description(): return .length

        default: return nil
        }
    }
    
    func getUnitSystems() -> [UnitSystemIdentifier] {
        switch self {
        case .mass: return [.kilogram, .pound, .gram]
        case .time: return [.second, .minute, .hour]
        case .length: return [.meter, .centimeter, .milimeter, .kilometer]
        }
    }
    
    func description() -> String {
        switch self {
        case .mass: return "Mass"
        case .time: return "Time"
        case .length: return "Distance"
        }
    }
}
