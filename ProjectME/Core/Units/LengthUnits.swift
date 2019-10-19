//
//  LengthUnits.swift
//  ProjectME
//
//  Created by Robert Sandru on 10/19/19.
//  Copyright © 2019 codecontrive. All rights reserved.
//

import Foundation

enum Meter: Unit {
    
    static var conversionFactor: Double {
        return 1
    }
}

enum Centimeter: Unit {
    
    static var conversionFactor: Double {
        return 0.01
    }
}

enum Milimeter: Unit {
    
    static var conversionFactor: Double {
        return 0.001
    }
}
