//
//  Unit.swift
//  ProjectME
//
//  Created by Robert Sandru on 10/19/19.
//  Copyright © 2019 codecontrive. All rights reserved.
//

import Foundation

protocol Unit {
    static var conversionFactor: Double { get }
}

extension Unit { }

class UnitSystem<T: Unit>: Hashable {
    
    var value: Double
    
    init(value: Double) {
        self.value = value
    }
    
    static func +(lhs: UnitSystem<T>, rhs: UnitSystem<T>) -> UnitSystem<T> {
        return UnitSystem<T>(value: lhs.value + rhs.value)
    }
    
    static func == (lhs: UnitSystem<T>, rhs: UnitSystem<T>) -> Bool {
        return lhs.value == rhs.value
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(value)
    }
}
