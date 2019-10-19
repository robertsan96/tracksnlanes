//
//  HomeTableViewController.swift
//  ProjectME
//
//  Created by Robert Sandru on 10/19/19.
//  Copyright © 2019 codecontrive. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {

    var viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.clearsSelectionOnViewWillAppear = false
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        title = "Home"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.register(HomeTrackTableViewCell.self, forCellReuseIdentifier: "HomeTrackTableViewCell")
        tableView.register(HomeOptionTableViewCell.self, forCellReuseIdentifier: "HomeOptionTableViewCell")
        tableView.tableFooterView = UIView()
        
        view.backgroundColor = UIColor.systemBackground
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
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

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
