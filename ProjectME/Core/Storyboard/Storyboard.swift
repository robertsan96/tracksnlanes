//
//  Storyboard.swift
//  ProjectME
//
//  Created by Robert Sandru on 10/19/19.
//  Copyright © 2019 codecontrive. All rights reserved.
//

import UIKit

struct Storyboard {
    
    enum Storyboards: String {
        case main = "Main"
        case lane = "Lane"
        case track = "Track"
        case predefinedLanes = "PredefinedLanes"
    }
    
    enum StoryboardError: Error {
        case couldNotInstantiateViewController
    }
    
    static func getVC<T: UIViewController>(with identifier: String, in storyboard: Storyboards = .main) throws -> T {
        let storyboard = UIStoryboard(name: storyboard.rawValue, bundle: .main)
        if let vc = storyboard.instantiateViewController(identifier: identifier) as? T {
            return vc
        } else {
            throw StoryboardError.couldNotInstantiateViewController
        }
    }
}
