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
    
    init(buildingTrack: TrackModel) {
        self.mode.accept(.createWithoutSave)
        self.track = BehaviorRelay(value: buildingTrack)
    }
}
