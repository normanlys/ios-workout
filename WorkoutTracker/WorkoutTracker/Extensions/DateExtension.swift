//
//  DateFormatterExtension.swift
//  WorkoutTracker
//
//  Created by Norman Lim on 8/5/2019.
//  Copyright © 2019 Norman Lim. All rights reserved.
//

import Foundation

extension DateFormatter {
    open class var standard: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        formatter.timeZone = TimeZone.current
        formatter.locale = Locale.current
        formatter.calendar = Calendar.current
        return formatter
    }
}

extension DateComponentsFormatter {
    open class var standard: DateComponentsFormatter {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .abbreviated
        formatter.allowedUnits = [.hour, .minute]
        return formatter
    }
}
