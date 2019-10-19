//
//  TimestampModel.swift
//  ProjectME
//
//  Created by Robert Sandru on 10/19/19.
//  Copyright © 2019 codecontrive. All rights reserved.
//

import Foundation

class TimestampModel {
    
    var createdAt: Date
    var updatedAt: Date?
    
    init(createdAt: Date, updatedAt: Date = Date.getDateInTimezone()) {
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}
