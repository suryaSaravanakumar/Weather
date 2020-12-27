//
//  WeatherDetailsViewModel.swift
//  Weather
//
//  Created by Surya on 27/12/20.
//

import Foundation

protocol WeatherDetailsProtocol {
    var didReceiveOneWeatherAPISuccess: ((OneWeatherModel) -> Void)? { get set }
    var didReceiveOneWeatherAPIFailure: ((Error,String) -> Void)? { get set }
    func invokeOneWeatherAPIWith(lat: String,long: String)
}

class WeatherDetailsViewModel: WeatherDetailsProtocol{
    var didReceiveOneWeatherAPISuccess: ((OneWeatherModel) -> Void)?
    var didReceiveOneWeatherAPIFailure: ((Error, String) -> Void)?
    
    func invokeOneWeatherAPIWith(lat: String, long: String) {
        //11.666839898921234
        //78.15546069028629
        let endPoint =  "https://api.openweathermap.org/data/2.5/onecall?lat=\(lat)&lon=\(long)&units=metric&exclude=[alerts]&appid=\(ApiKey.apiKey)"
        NetwokHelper.sharedInstance.callGetAPIWith(with: endPoint, responseType: OneWeatherModel.self) { (oneWeatherResponse) in
            self.didReceiveOneWeatherAPISuccess?(oneWeatherResponse)
        } failureBlock: { (error) in
            self.didReceiveOneWeatherAPIFailure?(error,"")
        }

    }
    
}
