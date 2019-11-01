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

    @IBOutlet weak var laneValueChangerView: UIView!
    
    var viewModel: LaneControlViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let laneValueChangerComponentVC = LaneValueChangerComponentViewController()
        addChild(laneValueChangerComponentVC)
        laneValueChangerView.addSubview(laneValueChangerComponentVC.view)
        laneValueChangerComponentVC.view.frame = laneValueChangerView.bounds
        laneValueChangerComponentVC.didMove(toParent: self)
    }
}
