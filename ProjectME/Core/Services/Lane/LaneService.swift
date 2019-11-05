//
//  LaneService.swift
//  ProjectME
//
//  Created by Robert Sandru on 11/5/19.
//  Copyright © 2019 codecontrive. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

/// The only endpoint allowed to CRUD lanes.
/// Using observable pattern having in mind a potential
/// asynchronous service such as a REST API.
class LaneService {
    
    func create() -> Observable<Bool> {
        return .just(true)
    }
    
    func update() -> Observable<Bool> {
        return .just(true)
    }
    
    func get() -> Observable<Bool> {
        return .just(true)
    }
    
    func delete() -> Observable<Bool> {
        return .just(true)
    }
}
