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
        tracks = [
            TrackModel(name: "Weight Loss", lanes: [
                LaneModel(name: "Kilograms"),
                LaneModel(name: "Arm Size"),
                LaneModel(name: "Belly Size"),
                LaneModel(name: "Leg Size"),
                LaneModel(name: "Seat Size"),
                LaneModel(name: "Jogging Lane")
            ], timestamp: TimestampModel(createdAt: "2015-04-01T11:42:00".getDate()!)),
            TrackModel(name: "Liquids", lanes: [
                LaneModel(name: "Periodic Kilometers"),
                LaneModel(name: "Oil Change Intervals"),
                LaneModel(name: "Brake Updates"),
                LaneModel(name: "Service Intervals")
            ], timestamp: TimestampModel(createdAt: "2019-10-19T14:23:10".getDate()!)),
            TrackModel(name: "Rent", lanes: [])
        ]
        
        options = [
            HomeOptionModel(name: "Settings", icon: "👨🏻‍🔧"),
            HomeOptionModel(name: "Profile", icon: "😎"),
            HomeOptionModel(name: "Purchases", icon: "💰"),
            HomeOptionModel(name: "Market", icon: "💹")
        ]
    }
}
