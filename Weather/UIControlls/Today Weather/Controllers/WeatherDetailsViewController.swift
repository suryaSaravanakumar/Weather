//
//  ViewController.swift
//  Weather
//
//  Created by Surya on 27/12/20.
//

import UIKit

class WeatherDetailsViewController: UIViewController {
    
    //MARK: - IBOulet Declaration
    
    //MARK: - Property Declaration
    var viewModel: WeatherDetailsViewModel = {
        return WeatherDetailsViewModel()
    }()
    var todayWeather: Current?
    var hourlyWeather: [Hourly]?
    var dailyWeather: [Daily]?
    
    //MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initalSetup()
    }
    
    //MARK: - Custom Methods
    private func initalSetup(){
        callOneWeatherAPI()
    }
    
    private func tableViewSetup(){
        
    }
    
    private func callOneWeatherAPI(){
        viewModel.didReceiveOneWeatherAPISuccess = { [weak self](oneWeatherResponse) in
            self?.todayWeather = oneWeatherResponse.current
            self?.hourlyWeather = oneWeatherResponse.hourly
            self?.dailyWeather = oneWeatherResponse.daily
            print("API Sucess")
        }
        
        viewModel.didReceiveOneWeatherAPIFailure = { (error,statusCode) in
            print(error,"API Failed")
        }
        
        viewModel.invokeOneWeatherAPIWith(lat: "11.666839898921234", long: "78.15546069028629")
    }
    
    //MARK: - IBAction Methods
    
    
}

