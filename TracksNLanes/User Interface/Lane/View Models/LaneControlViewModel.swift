//
//  LaneControlViewModel.swift
//  TracksNLanes
//
//  Created by Robert Sandru on 10/31/19.
//  Copyright © 2019 codecontrive. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class LaneControlViewModel: UIViewModel {
    
    var lane: LaneModel
    var disposeBag = DisposeBag()
    
    init(lane: LaneModel, withDelegate delegate: UIViewModelDelegate? = nil) {
        
        self.lane = lane
        super.init(withDelegate: delegate)
    }
}
