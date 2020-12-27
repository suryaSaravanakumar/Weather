//
//  File.swift
//  Weather
//
//  Created by Surya on 27/12/20.
//

import UIKit

struct ApiKey {
    static let apiKey = "9bf9678ebb19ac14d76e33f3c3f93621"
}

struct Helper {
    
    static func weatherImageURL(weatherType: String) -> UIImage{
        switch weatherType{
        case WeatherCondition.clouds.rawValue.capitalized:
            return WeatherImages.clouds
        case WeatherCondition.clear.rawValue.capitalized:
            return WeatherImages.clear
        case WeatherCondition.drizzle.rawValue.capitalized:
            return WeatherImages.drizzle
        case WeatherCondition.rain.rawValue.capitalized:
            return WeatherImages.rain
        case WeatherCondition.thunderstorm.rawValue.capitalized:
            return WeatherImages.thunderstorm
        case WeatherCondition.dust.rawValue.capitalized:
            return WeatherImages.dust
        case WeatherCondition.dust.rawValue.capitalized:
            return WeatherImages.dust
        default:
            return WeatherImages.clouds
        }
    }
    
    static func unixTodateConverter(withUnix unix: Double,needFormat format: DateFormats) -> String{
        let date = Date(timeIntervalSince1970: unix)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.rawValue
        dateFormatter.timeZone = .current
        let localDate = dateFormatter.string(from: date)
        return localDate
    }
}
