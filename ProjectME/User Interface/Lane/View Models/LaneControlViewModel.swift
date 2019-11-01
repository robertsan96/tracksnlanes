//
//  LaneControlViewModel.swift
//  ProjectME
//
//  Created by Robert Sandru on 10/31/19.
//  Copyright © 2019 codecontrive. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class LaneControlViewModel {
    
    var lane: BehaviorRelay<LaneModel?> = BehaviorRelay(value: nil)
    var disposeBag = DisposeBag()
    
    init(lane: LaneModel) {
        self.lane.accept(lane)
    }
}
