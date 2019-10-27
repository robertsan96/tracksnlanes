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
    
    init() {
        setPredefinedLanes()
    }
    
    func setPredefinedLanes() {
        let predefinedLanes: [LaneModel] = CoreDataService.shared.get().filter { lane -> Bool in
            return lane.system
        }
        self.lanes.accept(predefinedLanes)
    }
    
    func selectedPredefinedLanes(from table: UITableView) -> [LaneModel] {
        var selectedPredefinedLanes: [LaneModel] = []
        
        for selectedIndexPath in table.indexPathsForSelectedRows ?? [] {
            selectedPredefinedLanes.append(lanes.value[selectedIndexPath.row])
        }
        return selectedPredefinedLanes
    }
    
    func didAddTemporary(lane: LaneModel, in trackCreationService: TrackCreationService) {
        trackCreationService.buildingTrackModel.addToLanes(lane)
    }
}
