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
    
    init(name: String, lanes: [LaneModel]) {
        self.name = name
        self.lanes = lanes
    }
}
