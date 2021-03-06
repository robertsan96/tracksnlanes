//
//  LaneControlLayOneViewController.swift
//  TracksNLanes
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
    
    private var laneValueChangerVC: LaneNumericValueChangerViewController?
    private var laneValueViewerVC: LaneNumericViewerTableViewController?
    
    var viewModel: LaneControlViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate?.didInitInitialData()
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
        let laneValueChangerComponentVM = LaneNumericValueChangerViewModel(with: lane)
        
        laneValueChangerComponentVC.viewModel = laneValueChangerComponentVM
        laneValueChangerComponentVM.delegate = laneValueChangerComponentVC
        
        addChild(laneValueChangerComponentVC)
        laneValueChangerView.addSubview(laneValueChangerComponentVC.view)
        laneValueChangerComponentVC.view.frame = laneValueChangerView.bounds
        laneValueChangerComponentVC.didMove(toParent: self)
        
        self.laneValueChangerVC = laneValueChangerComponentVC
    }
    
    /// Must be called as soon as we have the lane model.
    func setupLaneValueViewerVC(for lane: LaneModel) {
        
        laneValueViewerView.backgroundColor = .systemBackground
        
        let laneValueViewerComponentVC = LaneNumericViewerTableViewController()
        let laneValueViewerComponentVM = LaneNumericViewerViewModel(with: lane)
        
        laneValueViewerComponentVC.viewModel = laneValueViewerComponentVM
        addChild(laneValueViewerComponentVC)
        laneValueViewerView.addSubview(laneValueViewerComponentVC.view)
        laneValueViewerComponentVC.view.frame = laneValueViewerView.bounds
        laneValueViewerComponentVC.didMove(toParent: self)
        
        self.laneValueViewerVC = laneValueViewerComponentVC
    }
}

// MARK: - UIViewModelDelegate
extension LaneControlLayOneViewController: UIViewModelDelegate {
    
    func didInitInitialData() {
        precondition(viewModel != nil, "View Model is not initialized.")
        setupLaneHeaderVC(for: viewModel!.lane)
        setupLaneValueChangerVC(for: viewModel!.lane)
        setupLaneValueViewerVC(for: viewModel!.lane)
    }
}

// MARK: - Rx
extension LaneControlLayOneViewController {
    
    func observe() {
        /// Have in mind that the the subscription returns the number of entries until you add. If you add,
        /// the subscription will have 1 exactly entry! Research.
        viewModel.lane.rx.observe(NSSet.self, "entries").subscribe(onNext: { _ in
            self.laneValueViewerVC?.tableView.reloadData()
        }).disposed(by: viewModel.disposeBag)
    }
}
