//
//  HomeViewModel.swift
//  TracksNLanes
//
//  Created by Robert Sandru on 10/19/19.
//  Copyright © 2019 codecontrive. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class HomeViewModel {
    
    enum TableSections: Int {
        case tracks = 0, options
    }
    
    var tracks: [TrackModel] = []
    var options: [HomeOptionModel] = []
    
    var updatedTracksSignal: PublishRelay<Bool> = PublishRelay()
    
    var disposeBag: DisposeBag = DisposeBag()
    
    init() {
        loadTracks()
        
        options = [
            HomeOptionModel(name: "Settings", icon: "👨🏻‍🔧"),
            HomeOptionModel(name: "Profile", icon: "😎"),
            HomeOptionModel(name: "Purchases", icon: "💰"),
            HomeOptionModel(name: "Market", icon: "💹")
        ]
    }
    
    func loadTracks() {
        tracks = CoreDataService.shared.get()
        updatedTracksSignal.accept(true)
    }
}
