//
//  LaneDetailViewController.swift
//  ProjectME
//
//  Created by Robert Sandru on 10/19/19.
//  Copyright © 2019 codecontrive. All rights reserved.
//

import UIKit

class LaneDetailViewController: UIViewController {
    
    @IBOutlet weak var laneNameTextFieldWithLabel: TextFieldWithLabel!
    @IBOutlet weak var laneUnitsTextFieldWithLabel: TextFieldWithLabel!
    @IBOutlet weak var laneUnitTextFieldWithLabel: TextFieldWithLabel!
    
    var viewModel: LaneDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        laneNameTextFieldWithLabel.label.text = "Name"
        laneNameTextFieldWithLabel.textField.placeholder = "Weight Loss Tracker"
        
        laneUnitsTextFieldWithLabel.label.text = "Type"
        laneUnitsTextFieldWithLabel.textField.text = "Mass"
        
        laneUnitTextFieldWithLabel.label.text = "Main Unit"
        laneUnitTextFieldWithLabel.textField.text = "Kilogram"
        
        observeChanges()
    }
}

extension LaneDetailViewController {
    
    func observeChanges() {
        viewModel.mode.subscribe(onNext: { [weak self] mode in
            self?.update(to: mode)
        }).disposed(by: viewModel.disposeBag)
    }
    
    func update(to mode: LaneDetailViewModel.Mode) {
        switch mode {
        case .create:
            title = "New Lane"
        case .edit:
            title = viewModel.track.value.name
        }
    }
}
