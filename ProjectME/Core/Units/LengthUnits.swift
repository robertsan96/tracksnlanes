//
//  LengthUnits.swift
//  ProjectME
//
//  Created by Robert Sandru on 10/19/19.
//  Copyright © 2019 codecontrive. All rights reserved.
//

import Foundation

enum Meter: Unit {
    
    static var unitSystemIdentifier: UnitSystemIdentifier {
        return .meter
    }
    
    static var conversionFactor: Double {
        return 1
    }
}

enum Centimeter: Unit {
    
    static var unitSystemIdentifier: UnitSystemIdentifier {
        return .centimeter
    }
    
    static var conversionFactor: Double {
        return 0.01
    }
}

enum Milimeter: Unit {
    
    static var unitSystemIdentifier: UnitSystemIdentifier {
        return .milimeter
    }
    
    static var conversionFactor: Double {
        return 0.001
    }
}

enum Kilometer: Unit {
    
    static var unitSystemIdentifier: UnitSystemIdentifier {
        return .kilometer
    }
    
    static var conversionFactor: Double {
        return 1000
    }
}
