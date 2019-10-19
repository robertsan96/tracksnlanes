//
//  HomeViewModel.swift
//  ProjectME
//
//  Created by Robert Sandru on 10/19/19.
//  Copyright © 2019 codecontrive. All rights reserved.
//

import Foundation

class HomeViewModel {
    
    enum TableSections: Int {
        case tracks = 0, options
    }
    
    var tracks: [TrackModel] = []
    var options: [HomeOptionModel] = []
    
    init() {
        tracks = CoreDataService.shared.get()
        
        options = [
            HomeOptionModel(name: "Settings", icon: "👨🏻‍🔧"),
            HomeOptionModel(name: "Profile", icon: "😎"),
            HomeOptionModel(name: "Purchases", icon: "💰"),
            HomeOptionModel(name: "Market", icon: "💹")
        ]
    }
}
