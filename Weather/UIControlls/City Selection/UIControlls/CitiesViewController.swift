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
    
    // MARK: - Property Declaration
    var currentWeather: Current?
    var currentCityData: OneWeatherModel?
    var selectedCitiesDict = [[String:String]]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initalSetup()
    }
    
    // MARK: - Custom Methods
    private func initalSetup(){
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
            self?.currentCityData = oneWeatherResponse
            if let cityData = self?.currentCityData{
                var citye:[String:String] = [:]
                citye["cityName"] = cityName
                citye["cityTemp"] = "\(cityData.current?.temp ?? 0)"
                citye["cityWeather"] = cityData.current?.weather?[0].main ?? ""
                self?.selectedCitiesDict.append(citye)
                
                //coreData
                let cityyData = City(context: self!.context)
                cityyData.cityName = cityName
                cityyData.cityLat = lat
                cityyData.cityLong = long
                cityyData.cityTemp = "\(cityData.current?.temp ?? 0)"
                cityyData.cityWeather = cityData.current?.weather?[0].main ?? ""
                self?.saveCoreDataContext()
                
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
        }
        
        weatherDetailsViewModel.didReceiveOneWeatherAPIFailure = { (error,statusCode) in
            print(error,"API Failed")
        }
        
        weatherDetailsViewModel.invokeOneWeatherAPIWith(lat: lat, long: long)
    }
    
    private func saveCoreDataContext(){
        do{
            try context.save()
        } catch {
            print("error saving coredata: \(error)")
        }
    }
    
    @IBAction func addCityBtnTapped(_ sender: UIButton) {
        guard let citySearchVC = UIStoryboard(name: "Cities", bundle: nil).instantiateViewController(identifier: "CitySearchViewController") as? CitySearchViewController else {return}
        citySearchVC.citySelectDelegate = self
        self.present(citySearchVC, animated: true, completion: nil)
        
    }
    
}

extension CitiesViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedCitiesDict.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { 140 }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell =  tableView.dequeueReusableCell(withIdentifier: CityTableViewCell.cellIdentifier, for: indexPath) as? CityTableViewCell else {
            return UITableViewCell()
        }
        
        if let currentCity = selectedCitiesDict[indexPath.row]["cityName"],
           let cityweather = selectedCitiesDict[indexPath.row]["cityWeather"],
           let cityTemp = selectedCitiesDict[indexPath.row]["cityTemp"]{
            cell.weatherTypeLbl.text = cityweather
            cell.cityLbl.text = currentCity
            cell.tempLbl.text = "\(cityTemp)° C"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    }
}

extension CitiesViewController: CitySelectDelegate{
    func didSelectCity(cityName: String,lat: String, long: String) {
        callOneWeatherAPI(lat: lat, long: long, cityName: cityName)
    }
    
    
}
