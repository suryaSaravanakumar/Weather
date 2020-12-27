//
//  Enums.swift
//  Weather
//
//  Created by Surya on 27/12/20.
//

import UIKit

enum DateFormats: String{
    case day = "E"
    case time12Hrs = "hh:mm a"
}


enum WeatherImages{
    static let clouds: UIImage = UIImage(systemName: "cloud.fill")!
    static let drizzle: UIImage = UIImage(systemName: "cloud.drizzle.fill")!
    static let rain: UIImage = UIImage(systemName: "cloud.heavyrain.fill")!
    static let thunderstorm: UIImage = UIImage(systemName: "cloud.bolt.fill")!
    static let snow: UIImage = UIImage(systemName: "cloud.snow.fill")!
    static let sunny: UIImage = UIImage(systemName: "cloud.sun.fill")!
    static let dust: UIImage = UIImage(systemName: "sun.dust.fill")!
    static let clear: UIImage = UIImage(systemName: "sun.max.fill")!
}

enum WeatherCondition: String{
    case thunderstorm
    case drizzle
    case rain
    case snow
    case clear
    case clouds
    case dust
    case mist
}

/**
 clear sky
 few clouds
 scattered clouds
 broken clouds
 shower rain
 rain
 thunderstorm
 snow
 mist
 
 Thunderstorm
 Rain
 Drizzle - cloud.drizzle
 Snow
 Clear
 Clouds
 
 //D
 Mist
 Haze
 Smoke
 */
