//
//  SelectPredefinedLanesTableViewController.swift
//  ProjectME
//
//  Created by Robert Sandru on 10/20/19.
//  Copyright © 2019 codecontrive. All rights reserved.
//

import UIKit

class SelectPredefinedLanesTableViewController: UITableViewController {

    var viewModel: SelectPredefinedLanesTableViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Shiny Lanes"
        
        tableView.tableFooterView = UIView()
        tableView.register(SelectPredefinedLaneTableViewCell.self,
                           forCellReuseIdentifier: "SelectPredefinedLaneTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        observeChanges()
    }

}

extension SelectPredefinedLanesTableViewController {
    
    func observeChanges() {
        viewModel.predefinedLanes.subscribe(onNext: { [weak self] predefinedLanes in
            self?.update(with: predefinedLanes)
        }).disposed(by: viewModel.disposeBag)
    }
    
    func update(with lanes: [LaneModel]) {
        tableView.reloadData()
    }
}

extension SelectPredefinedLanesTableViewController {
    
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
        cell.selectionStyle = .default
        cell.isSelected = false
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! SelectPredefinedLaneTableViewCell
        if cell.accessoryType == .checkmark {
            cell.accessoryType = .none
        } else {
            cell.accessoryType = .checkmark
        }
    }
}
