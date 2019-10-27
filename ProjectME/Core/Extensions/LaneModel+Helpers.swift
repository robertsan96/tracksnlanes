//
//  LaneHelper.swift
//  ProjectME
//
//  Created by Robert Sandru on 10/27/19.
//  Copyright © 2019 codecontrive. All rights reserved.
//

import Foundation

extension LaneModel {
    
    var isCustom: Bool {
        return (system == false) && (premium == false)
    }
    
    var isLockedCustom: Bool {
        return (system == false) && (premium == false) && (locked == true)
    }
    
    var isSystem: Bool {
        return (system == true)
    }
    
    var isLockedSystem: Bool {
        return (system == true) && (locked == true)
    }
    
    var isPremium: Bool {
        return (premium == true)
    }
    
    var isOwnedPremium: Bool {
        return (premium == true) && (locked == false)
    }
    
    var isLockedPremium: Bool {
        return (premium == true) && (locked == true)
    }
}
