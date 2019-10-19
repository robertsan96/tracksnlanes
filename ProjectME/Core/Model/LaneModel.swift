//
//  LaneModel.swift
//  ProjectME
//
//  Created by Robert Sandru on 10/19/19.
//  Copyright © 2019 codecontrive. All rights reserved.
//

import Foundation

class LaneModel {
    
    var name: String
    var type: ResourceType
    
    init(name: String, type: ResourceType = .predefined) {
        self.name = name
        self.type = type
    }
}
