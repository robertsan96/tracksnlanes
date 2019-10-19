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
        case tracks = 1, options
    }
    
    var tracks: [TrackModel] = []
    var options: [String] = []
    
    init() {
        tracks = [
            TrackModel(name: "My Weight Loss Tracker", lanes: [
                LaneModel(name: "Kilograms"),
                LaneModel(name: "Arm Size"),
                LaneModel(name: "Belly Size"),
                LaneModel(name: "Leg Size"),
                LaneModel(name: "Seat Size"),
                LaneModel(name: "Jogging Lane")
            ]),
            TrackModel(name: "My Car Tracker", lanes: [
                LaneModel(name: "Periodic Kilometers"),
                LaneModel(name: "Oil Change Intervals"),
                LaneModel(name: "Brake Updates"),
                LaneModel(name: "Service Intervals")
            ])
        ]
    }
}
