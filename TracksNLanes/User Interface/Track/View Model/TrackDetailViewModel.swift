//
//  TrackDetailViewModel.swift
//  TracksNLanes
//
//  Created by Robert Sandru on 10/20/19.
//  Copyright © 2019 codecontrive. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class TrackDetailViewModel {
    
    enum Mode {
        case create, edit
    }
    
    var trackModel: BehaviorRelay<TrackModel?> = BehaviorRelay(value: nil)
    var mode: BehaviorRelay<Mode> = BehaviorRelay(value: .create)
    var disposeBag: DisposeBag = DisposeBag()
    
    init(mode: Mode, track: TrackModel? = nil) {
        self.mode.accept(mode)
        self.trackModel.accept(track)
    }
}
