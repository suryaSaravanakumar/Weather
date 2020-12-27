//
//  TodayWeatherDetailsTableViewCell.swift
//  Weather
//
//  Created by Surya on 27/12/20.
//


import UIKit

class TodayWeatherDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var currentCityLbl: UILabel!
    @IBOutlet weak var temparatureLbl: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var weatherTypeLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    static var cellIdentifier = "TodayWeatherDetailsTableViewCell"
    
    static func nib() -> UINib{
         UINib(nibName: "TodayWeatherDetailsTableViewCell", bundle: nil)
    }
    
    func updateCell(withTodayWeather weather: Current){
        temparatureLbl.text = "\(weather.temp ?? 0)° C"
        weatherTypeLbl.text = "\(weather.weather?[0].main ?? "")"
    }
    
}
