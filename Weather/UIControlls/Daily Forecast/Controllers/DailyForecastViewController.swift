//
//  DailyForecastViewController.swift
//  Weather
//
//  Created by Surya on 27/12/20.
//

import UIKit

class DailyForecastViewController: UIViewController {
    
    // MARK: - IBOutlet Declaration
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Property Declaration
    var dailyForecast: [Daily]?
    
    
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
        tableView.register(DailyForecastTableViewCell.nib(), forCellReuseIdentifier: DailyForecastTableViewCell.cellIdentifier)
    
    }
    
}

extension DailyForecastViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dailyForecast?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { 330 }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell =  tableView.dequeueReusableCell(withIdentifier: DailyForecastTableViewCell.cellIdentifier, for: indexPath) as? DailyForecastTableViewCell else {
            return UITableViewCell()
        }
        
        if let weather = dailyForecast{
            cell.updateCell(WithDailyWeather: weather[indexPath.row])
        }
        return cell
    }
    
    
}

