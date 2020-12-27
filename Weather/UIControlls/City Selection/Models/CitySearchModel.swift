//
//  CitySearchModel.swift
//  Weather
//
//  Created by Surya on 27/12/20.
//

import Foundation

struct CitySearchModel : Codable {

    let country : String?
    let lat : Float?
    let lon : Float?
    let name : String?
    let state : String?

    enum CodingKeys: String, CodingKey {
        case country = "country"
        case lat = "lat"
        case lon = "lon"
        case name = "name"
        case state = "state"
    }
}
