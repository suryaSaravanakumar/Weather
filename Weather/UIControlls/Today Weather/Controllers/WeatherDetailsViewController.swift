//
//  ViewController.swift
//  Weather
//
//  Created by Surya on 27/12/20.
//

import UIKit

class WeatherDetailsViewController: UIViewController {
    
    //MARK: - IBOulet Declaration
    @IBOutlet weak var weatherTableView: UITableView!
    @IBOutlet weak var addCityBtn: UIButton!
    
    //MARK: - Property Declaration
    var todayWeather: Current?
    var hourlyWeather: [Hourly]?
    var dailyWeather: [Daily]?
    
    //MARK: - Instance Declaration
//    let viewModel = WeatherDetailsViewModel()
    var viewModel: WeatherDetailsViewModel = {
        return WeatherDetailsViewModel()
    }()
    
    //MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initalSetup()
    }
    
    //MARK: - Custom Methods
    private func initalSetup(){
        callOneWeatherAPI()
        tableViewSetup()
    }
    
    private func tableViewSetup(){
        weatherTableView.delegate = self
        weatherTableView.dataSource = self
        weatherTableView.tableFooterView = UIView()
        
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
    @IBAction func addCityBtnTapped(_ sender: UIButton) {
    }
    
    
}


extension WeatherDetailsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
}
