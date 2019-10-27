//
//  SelectLanesTableViewController.swift
//  ProjectME
//
//  Created by Robert Sandru on 10/20/19.
//  Copyright © 2019 codecontrive. All rights reserved.
//

import UIKit

class SelectLanesTableViewController: UITableViewController {

    var viewModel: SelectLanesTableViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Shiny Lanes"
        
        tableView.tableFooterView = UIView()
        tableView.register(UINib(nibName: "LaneTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "LaneTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsMultipleSelection = true
        tableView.separatorStyle = .none
        
        tableViewHeader()
        
        let createCustomLaneButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(onCreateCustomLane))
        let nextButton = UIBarButtonItem(title: "Next", style: .done, target: self, action: #selector(onNext))
        
        navigationItem.rightBarButtonItems = [nextButton, createCustomLaneButton]
        observeChanges()
    }

    @objc func onCreateCustomLane() {
        guard let trackCreationService = (navigationController as? TrackNavigationViewController)?.trackCreationService else {
            return
        }
        let laneNVC = try! Storyboard.getVC(with: "LaneNavigationViewController", in: .lane) as! UINavigationController
        let laneVC = try! Storyboard.getVC(with: "LaneDetailViewController", in: .lane) as! LaneDetailViewController
        let laneVM = LaneDetailViewModel(buildingTrack: trackCreationService.buildingTrackModel)
        laneVC.viewModel = laneVM
        laneNVC.pushViewController(laneVC, animated: true)
        laneVC.delegate = self
        
        laneNVC.navigationBar.prefersLargeTitles = true
        present(laneNVC, animated: true, completion: nil)
    }
    
    @objc func onNext() {
        let selectedPredefinedLanes = viewModel.selectedPredefinedLanes(from: tableView)
        let trackCreationService = (navigationController as? TrackNavigationViewController)?.trackCreationService
        trackCreationService?.addLanes(lanes: selectedPredefinedLanes)
        trackCreationService?.saveTrack()
        navigationController?.dismiss(animated: true, completion: nil)
    }
}

extension SelectLanesTableViewController {
    
    func observeChanges() {
        viewModel.lanes.subscribe(onNext: { [weak self] predefinedLanes in
            self?.update(with: predefinedLanes)
        }).disposed(by: viewModel.disposeBag)
    }
    
    func update(with lanes: [LaneModel]) {
        tableView.reloadData()
    }
}

extension SelectLanesTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.lanes.value.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LaneTableViewCell", for: indexPath) as! LaneTableViewCell
        
        let lane = viewModel.lanes.value[indexPath.row]
        
        cell.load(lane: lane)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        let lane = viewModel.lanes.value[indexPath.row]
        if lane.locked {
            print("Show us some keys to unlock the lane. 😎")
            let alert = UIAlertController(title: "Locked", message: "Buy?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "YEAH", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return nil
        } else {
            return indexPath
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! LaneTableViewCell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case SelectLanesTableViewModel.TableSections.custom.rawValue: return 300
        case SelectLanesTableViewModel.TableSections.system.rawValue: return 200
        default: return 200
        }
    }
    
    func tableViewHeader() {

        let tableHeaderView = UIView(frame: CGRect(x: 0,
                                                   y: 0,
                                                   width: tableView.frame.width,
                                                   height: 30))
        let tableHeader = UILabel(frame: CGRect(origin: CGPoint(x: 20,
                                                                y: 0),
                                                size: CGSize(width: tableHeaderView.frame.width-20,
                                                             height: tableHeaderView.frame.height)))
        tableHeader.font = UIFont.preferredFont(forTextStyle: .caption1)
        tableHeader.numberOfLines = 10
        tableHeader.text = "Use a predefined lane or feel free to create a custom one."
        
        tableHeaderView.addSubview(tableHeader)
        tableView.tableHeaderView = tableHeaderView
    }
}

extension SelectLanesTableViewController: LaneDetailViewControllerDelegate {
    
    func didCreateLane(mode: LaneDetailViewModel.Mode, lane: LaneModel) {
        viewModel.lanes.accept(viewModel.lanes.value + [lane])
        tableView.reloadData()
    }
}
