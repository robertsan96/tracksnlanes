//
//  PageViewModel.swift
//  ProjectME
//
//  Created by Robert Sandru on 10/19/19.
//  Copyright © 2019 codecontrive. All rights reserved.
//

import UIKit

class PageViewModel {
    
    var viewControllers = [
        try! Storyboard.getVC(with: "ViewController")
    ]
}
