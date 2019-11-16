//
//  TrackService.swift
//  TracksNLanes
//
//  Created by Robert Sandru on 11/5/19.
//  Copyright © 2019 codecontrive. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class TrackService {
    
    var track: BehaviorRelay<TrackModel>
    
    init(with track: TrackModel) {
        self.track = BehaviorRelay(value: track)
    }
}
