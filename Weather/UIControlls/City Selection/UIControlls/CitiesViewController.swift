//
//  CitiesViewController.swift
//  Weather
//
//  Created by Surya on 27/12/20.
//

import UIKit
import CoreData

class CitiesViewController: UIViewController {
    
    // MARK: - IBOutlet Declaration
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loaderContainerView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Property Declaration
    var currentCityData: OneWeatherModel?
    var selectedCities = [City]()
    var cityChangeDelegate: CitySelectDelegate!
    
    
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initalSetup()
    }
    
    // MARK: - Custom Methods
    private func initalSetup(){
        selectedCities = DataBaseHelper.loadCityDataFromDB()
        tableViewSetup()
    }
    
    private func tableViewSetup(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
        tableView.register(CityTableViewCell.nib(), forCellReuseIdentifier: CityTableViewCell.cellIdentifier)
    
    }
    
    private func callOneWeatherAPI(lat: String, long: String,cityName: String){
        let weatherDetailsViewModel = WeatherDetailsViewModel()
        weatherDetailsViewModel.didReceiveOneWeatherAPISuccess = { [weak self](oneWeatherResponse) in
            DispatchQueue.main.async {
                self?.loaderContainerView.isHidden = true
                self?.activityIndicator.stopAnimating()
            }
            
            self?.currentCityData = oneWeatherResponse
            if let city = self?.currentCityData{
                let cityData = City(context: DataBaseHelper.context)
                cityData.cityName = cityName
                cityData.cityLat = lat
                cityData.cityLong = long
                cityData.cityTemp = "\(city.current?.temp ?? 0)"
                cityData.cityWeather = city.current?.weather?[0].main ?? ""
                DataBaseHelper.saveCoreDataContext()
                self?.selectedCities = DataBaseHelper.loadCityDataFromDB()
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
        }
        
        weatherDetailsViewModel.didReceiveOneWeatherAPIFailure = { (error,statusCode) in
            DispatchQueue.main.async {
                self.loaderContainerView.isHidden = true
                self.activityIndicator.stopAnimating()
            }
            print(error,"API Failed")
        }
        
        self.loaderContainerView.isHidden = false
        self.activityIndicator.startAnimating()
        weatherDetailsViewModel.invokeOneWeatherAPIWith(lat: lat, long: long)
    }
    
    
    @IBAction func addCityBtnTapped(_ sender: UIButton) {
        guard let citySearchVC = UIStoryboard(name: "Cities", bundle: nil).instantiateViewController(identifier: "CitySearchViewController") as? CitySearchViewController else {return}
        citySearchVC.citySelectDelegate = self
        self.present(citySearchVC, animated: true, completion: nil)
        
    }
    
}

extension CitiesViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedCities.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { 140 }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell =  tableView.dequeueReusableCell(withIdentifier: CityTableViewCell.cellIdentifier, for: indexPath) as? CityTableViewCell else {
            return UITableViewCell()
        }
        cell.weatherTypeLbl.text = selectedCities[indexPath.row].cityWeather
        cell.cityLbl.text = selectedCities[indexPath.row].cityName
        cell.tempLbl.text = "\(selectedCities[indexPath.row].cityTemp ?? "")° C"
        cell.weatherImage.image = Helper.weatherImageURL(weatherType: selectedCities[indexPath.row].cityWeather ?? "")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cityLat = selectedCities[indexPath.row].cityLat,
           let cityLong = selectedCities[indexPath.row].cityLong {
            cityChangeDelegate.didSelectCity(cityName: selectedCities[indexPath.row].cityName ?? "" ,
                                             lat: cityLat,
                                             long: cityLong )
        }
        
        self.dismiss(animated: true, completion: nil)
        
    }
}

extension CitiesViewController: CitySelectDelegate{
    func didSelectCity(cityName: String,lat: String, long: String) {
        callOneWeatherAPI(lat: lat, long: long, cityName: cityName)
    }
    
    
}
