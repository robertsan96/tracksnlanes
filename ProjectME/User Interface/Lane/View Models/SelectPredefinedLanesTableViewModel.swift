//
//  SelectPredefinedLanesTableViewModel.swift
//  ProjectME
//
//  Created by Robert Sandru on 10/20/19.
//  Copyright © 2019 codecontrive. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class SelectPredefinedLanesTableViewModel {
    
    var predefinedLanes: BehaviorRelay<[LaneModel]> = BehaviorRelay(value: [])
    
    var disposeBag: DisposeBag = DisposeBag()
    
    init() {
        setPredefinedLanes()
    }
    
    func setPredefinedLanes() {
        let predefinedLanes: [LaneModel] = CoreDataService.shared.get().filter { lane -> Bool in
            return lane.system
        }
        self.predefinedLanes.accept(predefinedLanes)
    }
    
    func selectedPredefinedLanes(from table: UITableView) -> [LaneModel] {
        var selectedPredefinedLanes: [LaneModel] = []
        
        for selectedIndexPath in table.indexPathsForSelectedRows ?? [] {
            selectedPredefinedLanes.append(predefinedLanes.value[selectedIndexPath.row])
        }
        
        
        return selectedPredefinedLanes
    }
}
