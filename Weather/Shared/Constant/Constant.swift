//
//  File.swift
//  Weather
//
//  Created by Surya on 27/12/20.
//

import Foundation

struct ApiKey {
    static let apiKey = "9bf9678ebb19ac14d76e33f3c3f93621"
}

struct Helper {
    static func unixTodateConverter(withUnix unix: Double,needFormat format: DateFormats) -> String{
        //Mon or Monday
        // Hour
        // Fri 10 : 30
        let date = Date(timeIntervalSince1970: unix)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.rawValue
        //            dateFormatter.timeStyle = DateFormatter.Style.medium //Set time style
        //            dateFormatter.dateStyle = DateFormatter.Style.medium //Set date style
        dateFormatter.timeZone = .current
        let localDate = dateFormatter.string(from: date)
        return localDate
    }
}
