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
        tableView.register(SelectPredefinedLaneTableViewCell.self,
                           forCellReuseIdentifier: "SelectPredefinedLaneTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsMultipleSelection = true
        
        tableViewHeader()
        
        let createCustomLaneButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(onCreateCustomLane))
        let nextButton = UIBarButtonItem(title: "Next", style: .done, target: self, action: #selector(onNext))
        
        navigationItem.rightBarButtonItems = [nextButton, createCustomLaneButton]
        observeChanges()
    }

    @objc func onCreateCustomLane() {
        
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
        viewModel.predefinedLanes.subscribe(onNext: { [weak self] predefinedLanes in
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
        return viewModel.predefinedLanes.value.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SelectPredefinedLaneTableViewCell", for: indexPath)
        let lane = viewModel.predefinedLanes.value[indexPath.row]
        cell.textLabel?.text = lane.name
        cell.detailTextLabel?.text = lane.descriptionShort
        cell.selectionStyle = .default
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! SelectPredefinedLaneTableViewCell
        if cell.accessoryType == .checkmark {
            cell.accessoryType = .none
        } else {
            cell.accessoryType = .checkmark
            cell.isSelected = true
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
