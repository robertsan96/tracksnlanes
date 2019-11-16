//
//  PageViewModel.swift
//  TracksNLanes
//
//  Created by Robert Sandru on 10/19/19.
//  Copyright © 2019 codecontrive. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class PageViewModel {
    
    enum State {
        case idle
        case noLanes
    }
    
    var viewControllers: [UIViewController] = []
    var trackService: TrackService
    var vcState: BehaviorRelay<State> = BehaviorRelay(value: .idle)
    var disposeBag: DisposeBag = DisposeBag()
    
    init(track: TrackModel) {
        trackService = TrackService(with: track)
        
        processLanes()
    }
        
    func processLanes() {
        if trackService.track.value.lanes?.count == 0 {
            let noLanesVC = try! Storyboard.getVC(with: "NoLanesViewController")
            viewControllers.append(noLanesVC)
            vcState.accept(.noLanes)
        } else {
            // only set the first vc.
            let vc = try! Storyboard.getVC(with: "ViewController")
            viewControllers.append(vc)
            vcState.accept(.idle)
        }
    }
}
