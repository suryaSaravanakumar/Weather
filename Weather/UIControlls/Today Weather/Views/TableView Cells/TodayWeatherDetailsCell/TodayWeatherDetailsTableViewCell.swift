//
//  TodayWeatherDetailsTableViewCell.swift
//  Weather
//
//  Created by Surya on 27/12/20.
//


import UIKit

class TodayWeatherDetailsTableViewCell: UITableViewCell {

    //MARK: - IBOutlet Declaration
    @IBOutlet weak var currentCityLbl: UILabel!
    @IBOutlet weak var temparatureLbl: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var weatherTypeLbl: UILabel!
    
    //MARK: - Type Methods
    static let cellIdentifier = "TodayWeatherDetailsTableViewCell"
    static func nib() -> UINib{
         UINib(nibName: "TodayWeatherDetailsTableViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    //MARK: - Custom Methods
    func updateCell(withTodayWeather weather: Current, cityName: String){
        currentCityLbl.text = cityName
        temparatureLbl.text = "\(weather.temp ?? 0)° C"
        weatherTypeLbl.text = "\(weather.weather?[0].main?.capitalized ?? "")"
        weatherImage.image = Helper.weatherImageURL(weatherType: weather.weather?[0].main?.capitalized ?? "")
       
    }
    
}
