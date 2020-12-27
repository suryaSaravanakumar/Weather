//
//  CitySearchViewModel.swift
//  Weather
//
//  Created by Surya on 27/12/20.
//

import Foundation

import Foundation

protocol CitySearchProtocol {
    var didReceiveCitySearchAPISuccess: (([CitySearchModel]) -> Void)? { get set }
    var didReceiveCitySearchAPIFailure: ((Error,String) -> Void)? { get set }
    func invokeOneWeatherAPIWith(with cityName: String)
}

class CitySearchViewModel: CitySearchProtocol{
    var didReceiveCitySearchAPISuccess: (([CitySearchModel]) -> Void)?
    var didReceiveCitySearchAPIFailure: ((Error, String) -> Void)?
    
    func invokeOneWeatherAPIWith(with cityName: String) {
        let endPoint =  "http://api.openweathermap.org/geo/1.0/direct?q=\(cityName)&limit=20&appid=\(ApiKey.apiKey)"
        NetwokHelper.sharedInstance.callGetAPIWith(with: endPoint, responseType: [CitySearchModel].self) { (searchResponse) in
            self.didReceiveCitySearchAPISuccess?(searchResponse)
        } failureBlock: { (error) in
            self.didReceiveCitySearchAPIFailure?(error,"")
        }

    }
    
}
