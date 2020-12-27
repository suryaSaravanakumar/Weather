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
    var selectedCityName: String = ""
    var isCityAdded = false
    
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
    
    override func viewDidAppear(_ animated: Bool) {
        loadData()
    }
    
    //MARK: - Custom Methods
    private func initalSetup(){
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
    
    private func loadData(){
        let city = DataBaseHelper.loadCityDataFromDB()
        if city.isEmpty {
            if !(isCityAdded){
                guard let citySearchVC = UIStoryboard(name: "Cities", bundle: nil).instantiateViewController(identifier: "CitySearchViewController") as? CitySearchViewController else {return}
                citySearchVC.citySelectDelegate = self
                citySearchVC.modalPresentationStyle = .fullScreen
                self.present(citySearchVC, animated: true, completion: nil)
            }
        }else{
            if let cityLat = city[0].cityLat,
               let cityLong = city[0].cityLong{
                selectedCityName =  city[0].cityName ?? ""
                callOneWeatherAPI(lat: cityLat, long: cityLong)
            }
        }
        
    }
    
    private func callOneWeatherAPI(lat: String,long: String){
        
        viewModel.didReceiveOneWeatherAPISuccess = { [weak self](oneWeatherResponse) in
            self?.todayWeather = oneWeatherResponse.current
            self?.hourlyWeather = oneWeatherResponse.hourly
            self?.dailyWeather = oneWeatherResponse.daily
            
            //Update Data Base for the first time
            let city = DataBaseHelper.loadCityDataFromDB()
            if city.isEmpty{
                if let citylat = oneWeatherResponse.lat,
                   let cityLong = oneWeatherResponse.lon,
                   let cityTemp = oneWeatherResponse.current?.temp,
                   let cityWeather = oneWeatherResponse.current?.weather?[0].main{
                    let cityData = City(context: DataBaseHelper.context)
                    cityData.cityName = self?.selectedCityName
                    cityData.cityLat = String(citylat)
                    cityData.cityLong = String(cityLong)
                    cityData.cityTemp = String(cityTemp)
                    cityData.cityWeather = String(cityWeather)
                    DataBaseHelper.saveCoreDataContext()
                }
            }
            
            DispatchQueue.main.async {
                self?.weatherTableView.reloadData()
            }
        }
        viewModel.didReceiveOneWeatherAPIFailure = { (error,statusCode) in
            print(error,"API Failed")
        }
        
        viewModel.invokeOneWeatherAPIWith(lat: lat, long: long)
        //"11.666839898921234", long: "78.15546069028629")
    }
    
    //MARK: - IBAction Methods
    @IBAction func addCityBtnTapped(_ sender: UIButton) {
        guard let addCityVC = UIStoryboard(name: "Cities", bundle: nil).instantiateViewController(identifier: "CitiesViewController") as? CitiesViewController else {return}
        addCityVC.cityChangeDelegate = self
        self.present(addCityVC, animated: true, completion: nil)
        
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
            return 240
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
                todayWeatherCell.updateCell(withTodayWeather: weather, cityName: selectedCityName)
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

extension WeatherDetailsViewController: CitySelectDelegate{
    func didSelectCity(cityName: String, lat: String, long: String) {
        isCityAdded = true
        selectedCityName = cityName
        callOneWeatherAPI(lat: lat, long: long)
    }
}
