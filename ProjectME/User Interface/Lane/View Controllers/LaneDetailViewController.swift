//
//  LaneDetailViewController.swift
//  ProjectME
//
//  Created by Robert Sandru on 10/19/19.
//  Copyright © 2019 codecontrive. All rights reserved.
//

import UIKit

protocol LaneDetailViewControllerDelegate: class {
    func didCreateLane(mode: LaneDetailViewModel.Mode, lane: LaneModel)
}

class LaneDetailViewController: UIViewController {
    
    @IBOutlet weak var laneNameTextFieldWithLabel: TextFieldWithLabel!
    @IBOutlet weak var laneUnitCategoryTextFieldWithLabel: TextFieldWithLabel!
    @IBOutlet weak var laneUnitTextFieldWithLabel: TextFieldWithLabel!
    
    weak var delegate: LaneDetailViewControllerDelegate?
    var viewModel: LaneDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        laneNameTextFieldWithLabel.label.text = "Name"
        laneNameTextFieldWithLabel.textField.placeholder = "Weight Loss Tracker"
        
        laneUnitCategoryTextFieldWithLabel.label.text = "Type"
        laneUnitCategoryTextFieldWithLabel.textField.text = "Mass"
        laneUnitCategoryTextFieldWithLabel.viewModel.accept(TextFieldWithLabelPickerViewModel(with: ["Mass", "Distance"]))
        laneUnitCategoryTextFieldWithLabel.observe()
        
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
        case .createWithoutSave:
            // update :))
            let lane = LaneModel(context: CoreDataService.shared.context)
            lane.name = laneNameTextFieldWithLabel.textField.text
            delegate?.didCreateLane(mode: viewModel.mode.value, lane: lane)
        case .edit:
            title = viewModel.track.value.name
        }
    }
}
