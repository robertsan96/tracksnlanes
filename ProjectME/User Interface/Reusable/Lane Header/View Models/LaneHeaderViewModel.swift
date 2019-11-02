//
//  LaneHeaderViewModel.swift
//  ProjectME
//
//  Created by Robert Sandru on 11/1/19.
//  Copyright © 2019 codecontrive. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class LaneHeaderViewModel {
    
    var lane: BehaviorRelay<LaneModel>
    
    var disposeBag = DisposeBag()
    
    init(with lane: LaneModel) {
        self.lane = BehaviorRelay(value: lane)
    }
}
