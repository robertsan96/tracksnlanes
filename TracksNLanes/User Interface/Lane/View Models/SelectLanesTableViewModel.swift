//
//  SelectLanesTableViewModel.swift
//  TracksNLanes
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
    
    /// Used to make the table selections persistent when you leave the screen.
    lazy var selectedLanes: [LaneModel] = []
    
    init() {
        setLanes()
    }
    
    func setLanes() {
        let predefinedLanes: [LaneModel] = CoreDataService.shared.get().filter { lane -> Bool in
            return lane.system || lane.premium
        }
        var temporaryLanes: [LaneModel] = []
        if let lanes = trackCreationService?.buildingTrackModel.lanes?.allObjects as? [LaneModel] {
            let sorted = lanes.sorted { lhs, rhs -> Bool in
                guard lhs.createdAt != nil, rhs.createdAt != nil else { return false }
                return lhs.createdAt! > rhs.createdAt!
            }
            temporaryLanes = sorted
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
        didSelectLane(lane: lane)
        setLanes()
    }
    
    func didSelectLane(lane: LaneModel) {
        selectedLanes.append(lane)
    }
    
    func didDeselectLane(lane: LaneModel) {
        let withoutLane = selectedLanes.filter { selectedLane -> Bool in
            return lane.objectID !== selectedLane.objectID
        }
        selectedLanes = withoutLane
    }
    
    func laneIsSelected(lane: LaneModel) -> Bool {
        let exists = selectedLanes.filter { selectedLane -> Bool in
            return lane.objectID == selectedLane.objectID
        }.first
        
        return exists !== nil
    }
}
