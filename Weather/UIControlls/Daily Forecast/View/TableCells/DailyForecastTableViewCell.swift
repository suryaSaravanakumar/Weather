//
//  DailyForecastTableViewCell.swift
//  Weather
//
//  Created by Surya on 27/12/20.
//

import UIKit

class DailyForecastTableViewCell: UITableViewCell {

    @IBOutlet weak var dayLbl: UILabel!
    @IBOutlet weak var weatherTypeLbl: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var sunriseLbl: UILabel!
    @IBOutlet weak var sunSetLbl: UILabel!
    @IBOutlet weak var minTempLbl: UILabel!
    @IBOutlet weak var maxTempLbl: UILabel!
    @IBOutlet weak var dayTempLbl: UILabel!
    @IBOutlet weak var nightTempLbl: UILabel!
    @IBOutlet weak var conainerView: UIView!
    
    //MARK: - Type Methods
    static let cellIdentifier = "DailyForecastTableViewCell"
    static func nib() -> UINib{
        UINib(nibName: "DailyForecastTableViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        conainerView.addAddCornerRadius()
    }
    
    func updateCell(WithDailyWeather weather: Daily){
        let day = Helper.unixTodateConverter(withUnix: Double(weather.dt ?? 0), needFormat: .day)
        let sunriseTime = Helper.unixTodateConverter(withUnix: Double(weather.sunrise ?? 0), needFormat: .time12Hrs)
        let sunSetTime = Helper.unixTodateConverter(withUnix: Double(weather.sunset ?? 0), needFormat: .time12Hrs)
        
        dayLbl.text = day
        weatherTypeLbl.text = "\(weather.weather?[0].main?.capitalized ?? "")"
        sunriseLbl.text = sunriseTime
        sunSetLbl.text = sunSetTime
        minTempLbl.text = "\(weather.temp?.min ?? 0)° C"
        maxTempLbl.text = "\(weather.temp?.max ?? 0)° C"
        dayTempLbl.text = "\(weather.temp?.day ?? 0)° C"
        nightTempLbl.text = "\(weather.temp?.night ?? 0)° C"
    }
}
