//
//  LaneViewModel.swift
//  ProjectME
//
//  Created by Robert Sandru on 10/19/19.
//  Copyright © 2019 codecontrive. All rights reserved.
//

import Foundation

class LaneViewModel<T: Unit> {
    
    var type: ResourceType
    
    init(type: ResourceType) {
        self.type = type
    }
}
