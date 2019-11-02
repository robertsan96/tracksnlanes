//
//  LaneHeaderViewController.swift
//  ProjectME
//
//  Created by Robert Sandru on 11/1/19.
//  Copyright © 2019 codecontrive. All rights reserved.
//

import UIKit

class LaneHeaderViewController: UIViewController {

    @IBOutlet weak var laneNameLabel: UILabel!
    @IBOutlet weak var laneUnitSystemLabel: UILabel!
    @IBOutlet weak var laneLockedImageView: UIImageView!
    @IBOutlet weak var laneTypeLabel: UILabel!
    
    var viewModel: LaneHeaderViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .tertiarySystemGroupedBackground
        view.cornerRadius = 15
        
        observe()
    }

    func updateView(with lane: LaneModel) {
        
        laneNameLabel.text = lane.name
        
        setUnitSystem(of: lane)
        setType(of: lane)
    }
    
    func setUnitSystem(of lane: LaneModel) {
        guard let usi = lane.unitSystemIdentifier else {
            laneUnitSystemLabel.text = "NOT SET"
            return
        }
        if let unitSystem = UnitSystemIdentifier.getUnitSystemIdentifier(for: usi) {
            laneUnitSystemLabel.text = unitSystem.getCategory().description().uppercased()
        } else {
            laneUnitSystemLabel.text = "NOT SET".uppercased()
        }
    }
    
    func setType(of lane: LaneModel) {
        
        if lane.system {
            if lane.premium {
                laneTypeLabel.text = "PREMIUM"
                if lane.locked {
                    laneTypeLabel.text = "3.66$"
                    laneTypeLabel.textColor = .systemRed
                } else {
                    laneTypeLabel.text = "OWNED PREMIUM"
                    laneTypeLabel.textColor = .systemGreen
                }
            } else {
                laneTypeLabel.text = "SYSTEM"
                laneTypeLabel.textColor = .label
            }
        } else {
            laneTypeLabel.text = "CUSTOM"
            laneTypeLabel.textColor = .label
        }
    }
}

extension LaneHeaderViewController {
    
    func observe() {
        
        guard let vm = viewModel else { return }
            
        vm.lane.subscribe(onNext: { [weak self] lane in
            self?.updateView(with: lane)
        }).disposed(by: vm.disposeBag)
    }
}
