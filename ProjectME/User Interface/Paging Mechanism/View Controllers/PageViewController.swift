//
//  PageViewController.swift
//  ProjectME
//
//  Created by Robert Sandru on 10/19/19.
//  Copyright © 2019 codecontrive. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController {

    var viewModel: PageViewModel = PageViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViewControllers(viewModel.viewControllers,
                           direction: .forward,
                           animated: true,
                           completion: nil)
        
//        dataSource = self
//        delegate = self
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
