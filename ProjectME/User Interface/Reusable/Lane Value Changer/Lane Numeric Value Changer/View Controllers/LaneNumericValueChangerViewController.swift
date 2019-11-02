//
//  LaneNumericValueChangerViewController.swift
//  ProjectME
//
//  Created by Robert Sandru on 11/2/19.
//  Copyright © 2019 codecontrive. All rights reserved.
//

import UIKit

protocol LaneNumericValueChangerProtocol: class {
    
    
}

class LaneNumericValueChangerViewController: UIViewController {

    var viewModel: LaneNumericValueChangerViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        observe()
    }
}

extension LaneNumericValueChangerViewController {
    
    func observe() {
        guard let vm = viewModel else { return }
        
        vm.lane.subscribe(onNext: { [weak self] lane in
            
        }).disposed(by: vm.disposeBag)
    }
}
