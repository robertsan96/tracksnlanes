//
//  HomeTableViewController.swift
//  TracksNLanes
//
//  Created by Robert Sandru on 10/19/19.
//  Copyright © 2019 codecontrive. All rights reserved.
//

import UIKit
import RxSwift

class HomeTableViewController: UITableViewController {

    var viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.clearsSelectionOnViewWillAppear = false
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        
        let createTrackButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(onCreateTrack))
        self.navigationItem.rightBarButtonItem = createTrackButton
        
        title = "Home"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.register(HomeTrackTableViewCell.self, forCellReuseIdentifier: "HomeTrackTableViewCell")
        tableView.register(HomeOptionTableViewCell.self, forCellReuseIdentifier: "HomeOptionTableViewCell")
        tableView.tableFooterView = UIView()
        
        view.backgroundColor = UIColor.systemBackground
        
        observeChanges()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    @objc func onCreateTrack() {
        let tracksNVC = try! Storyboard.getVC(with: "TrackNavigationViewController", in: .track) as! TrackNavigationViewController
        let trackVC = try! Storyboard.getVC(with: "TrackDetailViewController", in: .track) as! TrackDetailViewController
        let trackVM = TrackDetailViewModel(mode: .create)
        let trackCS = TrackCreationService()
        
        trackVC.viewModel = trackVM
        tracksNVC.viewControllers = [trackVC]
        tracksNVC.trackCreationService = trackCS
        
        trackCS.delegate = self
        
        present(tracksNVC, animated: true, completion: nil)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case HomeViewModel.TableSections.tracks.rawValue:
            return viewModel.tracks.count
        case HomeViewModel.TableSections.options.rawValue:
            return viewModel.options.count
        default: return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case HomeViewModel.TableSections.tracks.rawValue:
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTrackTableViewCell", for: indexPath) as! HomeTrackTableViewCell
            cell.load(track: viewModel.tracks[indexPath.row])
            return cell
        case HomeViewModel.TableSections.options.rawValue:
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeOptionTableViewCell", for: indexPath) as! HomeOptionTableViewCell
            cell.load(option: viewModel.options[indexPath.row])
            return cell
            
        default: return UITableViewCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 0, height: 50)))
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return (indexPath.section == HomeViewModel.TableSections.tracks.rawValue)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case HomeViewModel.TableSections.tracks.rawValue:
            let model = viewModel.tracks[indexPath.row]
            let pageVC = try! Storyboard.getVC(with: "PageViewController") as! PageViewController
            let pageVM = PageViewModel(track: model)
            pageVC.viewModel = pageVM
            navigationController?.pushViewController(pageVC, animated: true)
        case HomeViewModel.TableSections.options.rawValue:
            let model = viewModel.options[indexPath.row]
            print(model.name)
        default: break
        }
    }

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
//            tableView.deleteRows(at: [indexPath], with: .fade)
            
            let model = viewModel.tracks[indexPath.row]
            CoreDataService.shared.remove(object: model)
            viewModel.tracks.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            viewModel.loadTracks()
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
}

extension HomeTableViewController {
    
    func observeChanges() {
        viewModel.updatedTracksSignal.subscribe(onNext: { [weak self] tracks in
            self?.tableView.reloadData()
        }).disposed(by: viewModel.disposeBag)
    }
}

extension HomeTableViewController: TrackCreationServiceDelegate {
    
    func didCreateTrack(track: TrackModel) {
        viewModel.loadTracks()
    }
}
