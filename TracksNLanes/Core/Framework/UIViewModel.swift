//
//  UIViewModel.swift
//  TracksNLanes
//
//  Created by Robert Sandru on 11/16/19.
//  Copyright © 2019 codecontrive. All rights reserved.
//

import Foundation

protocol UIViewModelDelegate: class {
    
    func didInitInitialData()
}

class UIViewModel {
    
    weak var delegate: UIViewModelDelegate?
    
    init(withDelegate delegate: UIViewModelDelegate? = nil) {
        self.delegate = delegate
    }
}
