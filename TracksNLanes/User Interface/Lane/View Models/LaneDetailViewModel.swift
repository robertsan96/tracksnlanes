//
//  LaneDetailViewModel.swift
//  TracksNLanes
//
//  Created by Robert Sandru on 10/19/19.
//  Copyright © 2019 codecontrive. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class LaneDetailViewModel {
    
    enum Mode {
        case create, createWithoutSave, edit
    }
    
    var mode: BehaviorRelay<Mode> = BehaviorRelay(value: .create)
    var track: BehaviorRelay<TrackModel>
    var disposeBag: DisposeBag = DisposeBag()
    
    init(mode: Mode, track: TrackModel, lane: LaneModel) {
        self.mode.accept(mode)
        self.track = BehaviorRelay(value: track)
    }
    
    init(track: TrackModel) {
        self.mode.accept(.create)
        self.track = BehaviorRelay(value: track)
    }
    
    /// The `buildingTrack` refference is mandatory even if there is not use case for the moment.
    init(buildingTrack: TrackModel) {
        self.mode.accept(.createWithoutSave)
        self.track = BehaviorRelay(value: buildingTrack)
    }
    
    func getUnitCategoryNames() -> [String] {
        let categories = UnitSystemCategoryIdentifier.getAll()
        var categoryNames = [String]()
        categories.forEach { category in
            categoryNames.append(category.description())
        }
        return categoryNames
    }
    
    func getUnitNames(for category: UnitSystemCategoryIdentifier) -> [String] {
        let units = category.getUnitSystems()
        var unitNames = [String]()
        units.forEach { unit in
            unitNames.append(unit.getDescription())
        }
        return unitNames
    }
    
    func buildLane(name: String?,
                   shortDescription: String?,
                   longDescription: String?,
                   unitCategory: UnitSystemCategoryIdentifier,
                   unit: UnitSystemIdentifier) -> LaneModel {
        let lane = LaneModel(context: CoreDataService.shared.context)
        
        lane.name = name
        lane.descriptionShort = shortDescription
        lane.descriptionLong = longDescription
        lane.createdAt = Date.getDateInTimezone()
        lane.updatedAt = Date.getDateInTimezone()
        lane.system = false
        lane.premium = false
        lane.locked = false
        lane.temporary = true
        lane.unitSystemIdentifier = unit.rawValue
        return lane
    }
}
