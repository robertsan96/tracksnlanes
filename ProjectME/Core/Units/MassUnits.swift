//
//  MassUnit.swift
//  ProjectME
//
//  Created by Robert Sandru on 10/19/19.
//  Copyright © 2019 codecontrive. All rights reserved.
//

import Foundation

enum Kilogram: Unit {

    static var conversionFactor: Double {
        return 1
    }
}

enum Pound: Unit {
    
    static var conversionFactor: Double {
        return 0.453592
    }
}

enum Gram: Unit {
    
    static var conversionFactor: Double {
        return 0.001
    }
}
