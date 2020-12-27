//
//  UIString+GetDesiredDate.swift
//  Weather
//
//  Created by Surya on 27/12/20.
//

import Foundation

extension String{
    func unixTodateConverter(withUnix unix: String,needFormat format: String){
        //Mon or Monday
        // Hour
        // Fri 10 : 30
        let date = Date(timeIntervalSince1970: unix)
            let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
//            dateFormatter.timeStyle = DateFormatter.Style.medium //Set time style
//            dateFormatter.dateStyle = DateFormatter.Style.medium //Set date style
            dateFormatter.timeZone = .current
            let localDate = dateFormatter.string(from: date)
        print(localDate)
    }
}
