//
//  OneWeatherModel.swift
//  Weather
//
//  Created by Surya on 27/12/20.
//

import Foundation

struct OneWeatherModel : Codable {
    let current : Current?
    let daily : [Daily]?
    let hourly : [Hourly]?
    let lat : Float?
    let lon : Float?
    let timezone : String?
    let timezoneOffset : Int?

    enum CodingKeys: String, CodingKey {
        case current = "current"
        case daily = "daily"
        case hourly = "hourly"
        case lat = "lat"
        case lon = "lon"
        case timezone = "timezone"
        case timezoneOffset = "timezone_offset"
    }
}

struct Current : Codable {

    let clouds : Int?
    let dewPoint : Float?
    let dt : Int?
    let feelsLike : Float?
    let humidity : Int?
    let pressure : Int?
    let sunrise : Int?
    let sunset : Int?
    let temp : Float?
    let uvi : Float?
    let visibility : Int?
    let weather : [Weather]?
    let windDeg : Int?
    let windSpeed : Float?
    let rain : Rain?

    enum CodingKeys: String, CodingKey {
        case clouds = "clouds"
        case dewPoint = "dew_point"
        case dt = "dt"
        case feelsLike = "feels_like"
        case humidity = "humidity"
        case pressure = "pressure"
        case sunrise = "sunrise"
        case sunset = "sunset"
        case temp = "temp"
        case uvi = "uvi"
        case visibility = "visibility"
        case weather = "weather"
        case windDeg = "wind_deg"
        case windSpeed = "wind_speed"
        case rain = "rain"
    }
}

struct Hourly : Codable {

    let clouds : Int?
    let dewPoint : Float?
    let dt : Int?
    let feelsLike : Float?
    let humidity : Int?
    let pop : Int?
    let pressure : Int?
    let temp : Float?
    let uvi : Float?
    let visibility : Int?
    let weather : [Weather]?
    let windDeg : Int?
    let windSpeed : Float?
    let rain : Rain?

    enum CodingKeys: String, CodingKey {
        case clouds = "clouds"
        case dewPoint = "dew_point"
        case dt = "dt"
        case feelsLike = "feels_like"
        case humidity = "humidity"
        case pop = "pop"
        case pressure = "pressure"
        case temp = "temp"
        case uvi = "uvi"
        case visibility = "visibility"
        case weather = "weather"
        case windDeg = "wind_deg"
        case windSpeed = "wind_speed"
        case rain = "rain"
    }
}

struct Daily : Codable {

    let clouds : Int?
    let dewPoint : Float?
    let dt : Int?
    let feelsLike : FeelsLike?
    let humidity : Int?
    let pop : Float?
    let pressure : Int?
    let rain : Float?
    let sunrise : Int?
    let sunset : Int?
    let temp : Temp?
    let weather : [Weather]?
    let windDeg : Int?
    let windSpeed : Float?


    enum CodingKeys: String, CodingKey {
        case clouds = "clouds"
        case dewPoint = "dew_point"
        case dt = "dt"
        case feelsLike = "feels_like"
        case humidity = "humidity"
        case pop = "pop"
        case pressure = "pressure"
        case rain = "rain"
        case sunrise = "sunrise"
        case sunset = "sunset"
        case temp = "temp"
        case weather = "weather"
        case windDeg = "wind_deg"
        case windSpeed = "wind_speed"
    }
}

struct Weather : Codable {

    let descriptionField : String?
    let icon : String?
    let id : Int?
    let main : String?

    enum CodingKeys: String, CodingKey {
        case descriptionField = "description"
        case icon = "icon"
        case id = "id"
        case main = "main"
    }
}

struct Temp : Codable {

    let day : Float?
    let eve : Float?
    let max : Float?
    let min : Float?
    let morn : Float?
    let night : Float?

    enum CodingKeys: String, CodingKey {
        case day = "day"
        case eve = "eve"
        case max = "max"
        case min = "min"
        case morn = "morn"
        case night = "night"
    }
}

struct FeelsLike : Codable {
    let day : Float?
    let eve : Float?
    let morn : Float?
    let night : Float?

    enum CodingKeys: String, CodingKey {
        case day = "day"
        case eve = "eve"
        case morn = "morn"
        case night = "night"
    }
}

struct Rain : Codable {

    let oneHour : Float?
    
    enum CodingKeys: String, CodingKey {
        case oneHour = "1h"
    }
}
