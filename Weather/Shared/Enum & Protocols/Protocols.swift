//
//  Protocols.swift
//  Weather
//
//  Created by Surya on 27/12/20.
//

import Foundation


protocol CitySelectDelegate {
    func didSelectCity(cityName: String,lat: String,long: String)
}

protocol didChangeCityDelegate {
    func didChangeCity(weatherDetails: OneWeatherModel)
}
