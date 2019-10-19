//
//  TrackModel.swift
//  ProjectME
//
//  Created by Robert Sandru on 10/19/19.
//  Copyright © 2019 codecontrive. All rights reserved.
//

import Foundation

class TrackModel {
    
    var name: String
    var lanes: [LaneModel]
    
    var timestamp: TimestampModel
    
    init(name: String, lanes: [LaneModel], timestamp: TimestampModel? = nil) {
        self.name = name
        self.lanes = lanes
        if timestamp == nil {
            self.timestamp = TimestampModel(createdAt: Date())
        } else {
            self.timestamp = timestamp!
        }
    }
}
