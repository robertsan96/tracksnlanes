//
//  NSManagedObject+EntityName.swift
//  ProjectME
//
//  Created by Robert Sandru on 10/19/19.
//  Copyright © 2019 codecontrive. All rights reserved.
//

import CoreData

extension NSManagedObject {
    
    static var entityName: String {
        return description()
    }
}
