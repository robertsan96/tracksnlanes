//
//  LaneNumericViewerTableViewController.swift
//  ProjectME
//
//  Created by Robert Sandru on 11/2/19.
//  Copyright © 2019 codecontrive. All rights reserved.
//

import UIKit

class LaneNumericViewerTableViewController: UITableViewController {
        
    var viewModel: LaneNumericViewerViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        tableView.register(UINib(nibName: "LaneNumericEntryTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "LaneNumericEntryTableViewCell")
        
        observe()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
         
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return viewModel?.lane.value.entries?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "LaneNumericEntryTableViewCell", for: indexPath) as? LaneNumericEntryTableViewCell,
            let entries = viewModel?.lane.value.entries?.allObjects as? [LaneEntryModel] else {
            return UITableViewCell()
        }

        let isFirstCell = indexPath.row == 0
        let isLastCell = indexPath.row == entries.count - 1
        let isMidCell = !isFirstCell && !isLastCell
        let isSingleCell = isFirstCell && isLastCell
        
        if isSingleCell {
            cell.load(with: entries[indexPath.row], single: true)
            return cell
        }
        if isFirstCell {
            cell.load(with: entries[indexPath.row], first: true)
            return cell
        }
        if isLastCell {
            cell.load(with: entries[indexPath.row], last: true)
            return cell
        }
        if isMidCell {
            cell.load(with: entries[indexPath.row], mid: true)
            return cell
        }
        return UITableViewCell()
    }
    
//    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//
//        guard let cell = cell as? LaneNumericEntryTableViewCell,
//            let entries = viewModel?.lane.value.entries?.allObjects as? [LaneEntryModel] else {
//                return
//            }
//        let isFirstCell = indexPath.row == 0
//        let isLastCell = indexPath.row == entries.count - 1
//        let isMidCell = !isFirstCell && !isLastCell
//        if isFirstCell {
//            cell.load(with: entries[indexPath.row], first: true)
//        }
//        if isLastCell {
//            cell.load(with: entries[indexPath.row], last: true)
//        }
//        if isMidCell {
//
//        }
//    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}

extension LaneNumericViewerTableViewController {
    
    func observe() {
        guard let vm = viewModel else { return }
        
        vm.lane.subscribe(onNext: { [weak self] lane in
            self?.tableView.reloadData()
        }).disposed(by: vm.disposeBag)
    }
}
