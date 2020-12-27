//
//  CitySearchViewController.swift
//  Weather
//
//  Created by Surya on 27/12/20.
//

import UIKit

class CitySearchViewController: UIViewController {

    // MARK: - IBOutlet Declaration
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var loaderContainerView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Property Declaration
    var citySearchArr: [String] = []
    var citySearchModel: [CitySearchModel]?
    var citySelectDelegate: CitySelectDelegate!
    
    //MARK: - Instance Declaration
    var viewModel: CitySearchViewModel = {
        return CitySearchViewModel()
    }()
    
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initalSetup()
    }
    
    // MARK: - Custom Methods
    private func initalSetup(){
        tableViewSetup()
        searchBarSetup()
    }
    
    private func tableViewSetup(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.register(CityNameTableViewCell.nib(), forCellReuseIdentifier: CityNameTableViewCell.cellIdentifier)
    
    }
    
    private func searchBarSetup(){
        searchBar.delegate = self
        searchBar.searchTextField.textColor = .white
        searchBar.setShowsCancelButton(true, animated: true)
        searchBar.showsCancelButton = true
    }
    
    private func callSearchAPI(withCityName name: String){
        viewModel.didReceiveCitySearchAPISuccess = { [weak self] (serachResult) in
            self?.citySearchModel = serachResult
            self?.citySearchArr.removeAll()
            if let cityModel = self?.citySearchModel{
                cityModel.forEach { (city) in
                    if let state = city.state{
                        self?.citySearchArr.append("\(city.name ?? ""),\(state),\(city.country ?? "")")
                    }else{
                        self?.citySearchArr.append("\(city.name ?? ""),\(city.country ?? "")")
                    }
                }
                DispatchQueue.main.async {
                    self?.loaderContainerView.isHidden = true
                    self?.activityIndicator.stopAnimating()
                    self?.tableView.reloadData()
                }
            }
            
        }
        
        viewModel.didReceiveCitySearchAPIFailure = { (error,statusCode) in
            DispatchQueue.main.async {
                self.loaderContainerView.isHidden = true
                self.activityIndicator.stopAnimating()
            }
            print("API Fail")
        }
        
        self.loaderContainerView.isHidden = false
        self.activityIndicator.startAnimating()
        viewModel.invokeOneWeatherAPIWith(with: name)
    }
    
}

extension CitySearchViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  citySearchArr.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { 40 }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell =  tableView.dequeueReusableCell(withIdentifier: CityNameTableViewCell.cellIdentifier, for: indexPath) as? CityNameTableViewCell else {
            return UITableViewCell()
        }
        if citySearchArr.count > 0{
            cell.cityNameLbl.text = citySearchArr[indexPath.row]
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let citySearch = citySearchModel{
           let selectedCity = citySearch[indexPath.row]
            if let lattitude = selectedCity.lat,
               let Longitude = selectedCity.lon,
               let name = selectedCity.name{
                //Check DB to avoid Duplication
                let city = DataBaseHelper.loadCityDataFromDB()
                var isDuplicate = false
                city.forEach { (currentCity) in
                    if currentCity.cityName == selectedCity.name{
                        isDuplicate = true
                    }
                }
                if !(isDuplicate){
                    citySelectDelegate.didSelectCity(cityName: name,lat: String(lattitude), long: String(Longitude))
                    self.dismiss(animated: true, completion: nil)
                } else {
                    let alertController = UIAlertController(title: "City Already Added", message: "", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "Ok", style: .default) { _ in
                        self.dismiss(animated: true, completion: nil)
                    }
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: nil)
                }
                
               
            }
        }
    }
    
    
}

extension CitySearchViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text{
            callSearchAPI(withCityName: searchText)
        }
        searchBar.endEditing(true)
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.endEditing(true)
    }
}
