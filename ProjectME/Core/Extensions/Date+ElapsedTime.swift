//
//  Date+ElapsedTime.swift
//  ProjectME
//
//  Created by Robert Sandru on 10/19/19.
//  Copyright © 2019 codecontrive. All rights reserved.
//

import Foundation

extension Date {
    
    func elapsedTime() -> String {

        let interval = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self, to: Date.getDateInTimezone())

        if let year = interval.year, year > 0 {
            return year == 1 ? "1 year ago" : "\(year) years ago."
        }
        if let month = interval.month, month > 0 {
            return month == 1 ? "1 month ago" : "\(month) months ago."
        }
        if let day = interval.day, day > 0 {
            return day == 1 ? "Yesterday." : "\(day) days ago."
        }
        if let hour = interval.hour, hour > 0 {
            return hour == 1 ? "1 hour ago." : "\(hour) hours ago."
        }
        if let minute = interval.minute, minute > 0 {
            return minute == 1 ? "1 min ago." : "\(minute) minutes ago."
        }
        if let second = interval.second, second > 0 {
            return "just now."
        }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        return dateFormatter.string(from: self)
    }
}
