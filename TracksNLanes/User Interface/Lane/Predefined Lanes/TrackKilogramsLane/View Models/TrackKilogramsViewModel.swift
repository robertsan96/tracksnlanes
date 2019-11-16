//
//  TrackKilogramsViewModel.swift
//  TracksNLanes
//
//  Created by Robert Sandru on 10/19/19.
//  Copyright © 2019 codecontrive. All rights reserved.
//

import Foundation

class TrackKilogramsViewModel: LaneViewModel<Kilogram> {
    
    init(lane: LaneModel) {
        super.init(type: .predefined)
    }
}
