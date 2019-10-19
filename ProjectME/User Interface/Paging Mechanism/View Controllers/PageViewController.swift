//
//  PageViewController.swift
//  ProjectME
//
//  Created by Robert Sandru on 10/19/19.
//  Copyright © 2019 codecontrive. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController {

    var viewModel: PageViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.systemBackground
        dataSource = self
        delegate = self
        
        title = viewModel.track.value.name
        
        let createLaneButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(onCreateLane))
        navigationItem.rightBarButtonItem = createLaneButton
        
        observeChanges()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @objc func onCreateLane() {
        let laneNVC = try! Storyboard.getVC(with: "LaneNavigationViewController", in: .lane) as! UINavigationController
        let laneVC = try! Storyboard.getVC(with: "LaneDetailViewController", in: .lane) as! LaneDetailViewController
        let laneVM = LaneDetailViewModel(track: viewModel.track.value)
        laneVC.viewModel = laneVM
        laneNVC.viewControllers = [laneVC]
        present(laneNVC, animated: true, completion: nil)
    }
}

extension PageViewController {
    
    func observeChanges() {
        viewModel.vcState.subscribe(onNext: { [weak self] state in
            self?.updateView(to: state)
        }).disposed(by: viewModel.disposeBag)
    }
    
    func updateView(to state: PageViewModel.State) {
        
        switch state {
        case .idle:
            delegate = self
            dataSource = self
        case .noLanes:
            delegate = nil
            dataSource = nil
        }
        
        setViewControllers(viewModel.viewControllers,
                           direction: .forward,
                           animated: true,
                           completion: nil)
    }
}

extension PageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        return UIStoryboard(name: "Main", bundle: .main).instantiateViewController(identifier: "ViewController") as! ViewController
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        return nil
    }
}

extension PageViewController: UIPageViewControllerDelegate {
    
}
