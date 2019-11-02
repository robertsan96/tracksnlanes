//
//  LaneNumericValueChangerViewModel.swift
//  ProjectME
//
//  Created by Robert Sandru on 11/2/19.
//  Copyright © 2019 codecontrive. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class LaneNumericValueChangerViewModel {
    
    var lane: BehaviorSubject<LaneModel>
    var disposeBag = DisposeBag()
    
    init(with lane: LaneModel) {
        self.lane = BehaviorSubject(value: lane)
    }
}
