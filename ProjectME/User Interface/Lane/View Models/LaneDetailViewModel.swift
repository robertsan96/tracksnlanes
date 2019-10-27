//
//  LaneDetailViewModel.swift
//  ProjectME
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
    
    func buildLane(name: String?, unitCategory: UnitSystemCategoryIdentifier, unit: UnitSystemIdentifier) -> LaneModel {
        let lane = LaneModel(context: CoreDataService.shared.context)
        
        lane.name = name
//        pl3.descriptionShort = "Ugh.. it's been already a month! 🙍🏻‍♀️ We got you covered, girls! Log all your menstrual cycle activity in this lane and we promise you'll never be surprised again by your body. We use predictions and machine learning to cover you. All for free."
//        pl3.descriptionLong = "This lane is all about logging your water consumption. It will generate graphs, show you progress and it's able to send notifications."
//        pl3.createdAt = Date.getDateInTimezone()
//        pl3.updatedAt = Date.getDateInTimezone()
//        pl3.system = true
//        pl3.premium = false
//        pl3.locked = false
//        pl3.unitSystemIdentifier = UnitSystemIdentifier.hour.rawValue
        return lane
    }
}
