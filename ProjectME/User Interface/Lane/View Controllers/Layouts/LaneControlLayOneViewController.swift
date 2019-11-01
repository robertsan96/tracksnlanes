//
//  LaneControlLayOneViewController.swift
//  ProjectME
//
//  Created by Robert Sandru on 10/31/19.
//  Copyright © 2019 codecontrive. All rights reserved.
//

import UIKit

/// This is a basic layout that will control a lane: contains an value changer view and
/// a table with values at the bottom.
class LaneControlLayOneViewController: UIViewController {

    @IBOutlet weak var laneHeaderView: UIView!
    @IBOutlet weak var laneValueChangerView: UIView!
    
    var viewModel: LaneControlViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLaneHeaderVC()
        setupLaneValueChangerVC()
        observe()
    }
    
    func setupLaneHeaderVC() {
        laneHeaderView.backgroundColor = .clear
        
        let laneHeaderVC = LaneHeaderViewController()
        addChild(laneHeaderVC)
        laneHeaderView.addSubview(laneHeaderVC.view)
        laneHeaderVC.view.frame = laneHeaderView.bounds
        laneHeaderVC.didMove(toParent: self)
    }
    
    func setupLaneValueChangerVC() {
        laneValueChangerView.backgroundColor = .clear
        
        let laneValueChangerComponentVC = LaneValueChangerComponentViewController()
        addChild(laneValueChangerComponentVC)
        laneValueChangerView.addSubview(laneValueChangerComponentVC.view)
        laneValueChangerComponentVC.view.frame = laneValueChangerView.bounds
        laneValueChangerComponentVC.didMove(toParent: self)
    }
}

extension LaneControlLayOneViewController {
    
    func observe() {
        guard let vm = viewModel else { return }
        vm.lane.subscribe(onNext: { [weak self] lane in
            guard let `self` = self else { return }
//            self.laneNameLabel.text = lane?.name
//            self.laneShortDescriptionLabel.text = lane?.descriptionShort
        }).disposed(by: vm.disposeBag)
    }
}
