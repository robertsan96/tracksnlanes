//
//  SelectLanesTableViewModel.swift
//  ProjectME
//
//  Created by Robert Sandru on 10/20/19.
//  Copyright © 2019 codecontrive. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class SelectLanesTableViewModel {
    
    enum TableSections: Int {
        case custom = 0, system
    }
    
    var lanes: BehaviorRelay<[LaneModel]> = BehaviorRelay(value: [])
    
    var disposeBag: DisposeBag = DisposeBag()
    var trackCreationService: TrackCreationService?
    
    init() {
        setLanes()
    }
    
    func setLanes() {
        let predefinedLanes: [LaneModel] = CoreDataService.shared.get().filter { lane -> Bool in
            return lane.system || lane.premium
        }
        var temporaryLanes: [LaneModel] = []
        if let lanes = trackCreationService?.buildingTrackModel.lanes?.allObjects as? [LaneModel] {
            temporaryLanes = lanes
        }
        self.lanes.accept(temporaryLanes + predefinedLanes)
    }
    
    func selectedLanes(from table: UITableView) -> [LaneModel] {
        var selectedLanes: [LaneModel] = []
        
        for selectedIndexPath in table.indexPathsForSelectedRows ?? [] {
            selectedLanes.append(lanes.value[selectedIndexPath.row])
        }
        return selectedLanes
    }
    
    func didAddTemporary(lane: LaneModel) {
        trackCreationService?.buildingTrackModel.addToLanes(lane)
        setLanes()
    }
}
