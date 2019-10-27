//
//  TrackCreationService.swift
//  ProjectME
//
//  Created by Robert Sandru on 10/20/19.
//  Copyright © 2019 codecontrive. All rights reserved.
//

import Foundation

protocol TrackCreationServiceDelegate: class {
    func didCreateTrack(track: TrackModel)
}

class TrackCreationService {
    
    var buildingTrackModel: TrackModel
    
    weak var delegate: TrackCreationServiceDelegate?
    
    init() {
        buildingTrackModel = TrackModel(context: CoreDataService.shared.context)
        buildingTrackModel.system = false
    }
    
    func addLanes(lanes: [LaneModel]) {
        lanes.forEach { lane in
            if lane.system {
                let lClone = LaneModel(context: CoreDataService.shared.context)
                lClone.name = lane.name
                lClone.descriptionLong = lane.descriptionLong
                lClone.descriptionShort = lane.descriptionShort
                lClone.createdAt = Date.getDateInTimezone()
                lClone.updatedAt = Date.getDateInTimezone()
                lClone.system = false
                buildingTrackModel.addToLanes(lClone)
            }
            if lane.temporary {
                // do nothing, as the temporary lanes are already in the lanes set.
            }
        }
    }
    
    func saveTrack() {
        buildingTrackModel.createdAt = Date.getDateInTimezone()
        buildingTrackModel.updatedAt = Date.getDateInTimezone()
        CoreDataService.shared.store(object: buildingTrackModel)
        delegate?.didCreateTrack(track: buildingTrackModel)
    }
}
