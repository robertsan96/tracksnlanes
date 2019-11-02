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
    @IBOutlet weak var laneValueViewerView: UIView!
    
    var viewModel: LaneControlViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        observe()
    }
    
    /// Must be called as soon as we have the lane model.
    func setupLaneHeaderVC(for lane: LaneModel) {
        laneHeaderView.backgroundColor = .clear
        
        let laneHeaderVC = LaneHeaderViewController()
        let laneHeaderVM = LaneHeaderViewModel(with: lane)
        laneHeaderVC.viewModel = laneHeaderVM
        
        addChild(laneHeaderVC)
        laneHeaderView.addSubview(laneHeaderVC.view)
        laneHeaderVC.view.frame = laneHeaderView.bounds
        laneHeaderVC.didMove(toParent: self)
    }
    
    /// Must be called as soon as we have the lane model. 
    func setupLaneValueChangerVC(for lane: LaneModel) {
        laneValueChangerView.backgroundColor = .clear
        
        let laneValueChangerComponentVC = LaneNumericValueChangerViewController()
        
        addChild(laneValueChangerComponentVC)
        laneValueChangerView.addSubview(laneValueChangerComponentVC.view)
        laneValueChangerComponentVC.view.frame = laneValueChangerView.bounds
        laneValueChangerComponentVC.didMove(toParent: self)
    }
    
    /// Must be called as soon as we have the lane model.
    func setupLaneValueViewerVC(for lane: LaneModel) {
        
        laneValueViewerView.backgroundColor = .clear
        
        let laneValueViewerComponentVC = LaneNumericViewerTableViewController()
        let laneValueViewerComponentVM = LaneNumericViewerViewModel(with: lane)
        
        laneValueViewerComponentVC.viewModel = laneValueViewerComponentVM
        addChild(laneValueViewerComponentVC)
        laneValueViewerView.addSubview(laneValueViewerComponentVC.view)
        laneValueViewerComponentVC.view.frame = laneValueViewerView.bounds
        laneValueViewerComponentVC.didMove(toParent: self)
    }
}

extension LaneControlLayOneViewController {
    
    func observe() {
        guard let vm = viewModel else { return }
        vm.lane.subscribe(onNext: { [weak self] lane in
            guard let `self` = self, let lane = lane else { return }
            self.setupLaneHeaderVC(for: lane)
            self.setupLaneValueChangerVC(for: lane)
            self.setupLaneValueViewerVC(for: lane)
        }).disposed(by: vm.disposeBag)
    }
}
