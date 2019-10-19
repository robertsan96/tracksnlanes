//
//  TimeUnits.swift
//  ProjectME
//
//  Created by Robert Sandru on 10/19/19.
//  Copyright © 2019 codecontrive. All rights reserved.
//

import Foundation

enum Second: Unit {
    
    static var conversionFactor: Double {
        return 1
    }
}

enum Minute: Unit {
    
    static var conversionFactor: Double {
        return 60
    }
}

enum Hour: Unit {
    
    static var conversionFactor: Double {
        return 3600
    }
}
