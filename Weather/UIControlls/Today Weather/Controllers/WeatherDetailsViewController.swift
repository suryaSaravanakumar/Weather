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
        weatherTableView.separatorStyle = .none
        weatherTableView.tableFooterView = UIView()
        weatherTableView.register(TodayWeatherDetailsTableViewCell.nib(), forCellReuseIdentifier: TodayWeatherDetailsTableViewCell.cellIdentifier)
        weatherTableView.register(ForecastCollectionHolderTableViewCell.nib(), forCellReuseIdentifier: ForecastCollectionHolderTableViewCell.cellIdentifier)
        weatherTableView.register(otherWeatherDetailsTableViewCell.nib(), forCellReuseIdentifier: otherWeatherDetailsTableViewCell.cellIdentifier)
    }
    
    private func callOneWeatherAPI(){
        
        viewModel.didReceiveOneWeatherAPISuccess = { [weak self](oneWeatherResponse) in
            self?.todayWeather = oneWeatherResponse.current
            self?.hourlyWeather = oneWeatherResponse.hourly
            self?.dailyWeather = oneWeatherResponse.daily
            DispatchQueue.main.async {
                self?.weatherTableView.reloadData()
            }
        }
        
        viewModel.didReceiveOneWeatherAPIFailure = { (error,statusCode) in
            print(error,"API Failed")
        }
        
        viewModel.invokeOneWeatherAPIWith(lat: "11.666839898921234", long: "78.15546069028629")
    }
    
    //MARK: - IBAction Methods
    @IBAction func addCityBtnTapped(_ sender: UIButton) {
        guard let vc = UIStoryboard(name: "Cities", bundle: nil).instantiateViewController(identifier: "CitiesViewController") as? CitiesViewController else {return}
        //            vc.dailyForecast = dailyWeatherDetails
        self.present(vc, animated: true, completion: nil)
        
    }
    
    @IBAction func viewForecastBtnTapped(_ sender: UIButton) {
        if let dailyWeatherDetails = self.dailyWeather{
            guard let vc = UIStoryboard(name: "DailyForecast", bundle: nil).instantiateViewController(identifier: "DailyForecastViewController") as? DailyForecastViewController else {return}
            vc.dailyForecast = dailyWeatherDetails
            self.present(vc, animated: true, completion: nil)
        }
    }
    
}


extension WeatherDetailsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 270
        case 1:
            return 250
        case 2:
            return 170
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            guard let todayWeatherCell = tableView.dequeueReusableCell(withIdentifier: TodayWeatherDetailsTableViewCell.cellIdentifier, for: indexPath) as? TodayWeatherDetailsTableViewCell else {
                return UITableViewCell()}
            if let weather = todayWeather{
                todayWeatherCell.updateCell(withTodayWeather: weather)
            }
            return todayWeatherCell
        case 1:
            guard let otherWeatherDetailCell = tableView.dequeueReusableCell(withIdentifier: otherWeatherDetailsTableViewCell.cellIdentifier, for: indexPath) as? otherWeatherDetailsTableViewCell else {
                return UITableViewCell()}
            if let weather = todayWeather{
                otherWeatherDetailCell.updateCell(withTodayWeather: weather)
            }
            return otherWeatherDetailCell
        case 2:
            guard let forecastCollectionCell = tableView.dequeueReusableCell(withIdentifier: ForecastCollectionHolderTableViewCell.cellIdentifier, for: indexPath) as? ForecastCollectionHolderTableViewCell else {
                return UITableViewCell()}
            if let _ = self.hourlyWeather {
                forecastCollectionCell.collectionView.register(ForecastCollectionViewCell.nib(), forCellWithReuseIdentifier: ForecastCollectionViewCell.cellIdentifier)
                forecastCollectionCell.collectionView.delegate = self
                forecastCollectionCell.collectionView.dataSource = self
            }
            return forecastCollectionCell
            
        default:
            return UITableViewCell()
        }
        
        
    }
}
