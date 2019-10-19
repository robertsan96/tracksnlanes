//
//  String+GetDate.swift
//  ProjectME
//
//  Created by Robert Sandru on 10/19/19.
//  Copyright © 2019 codecontrive. All rights reserved.
//

import Foundation

extension String {
    
    func getDate() -> Date? {
        let format = DateFormatter()
        format.timeZone = .current
        format.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let date = format.date(from: self)
        return date?.getDateInTimezone()
    }
}
