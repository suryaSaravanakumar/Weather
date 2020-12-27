//
//  ForecastCollectionViewCell.swift
//  testWeather
//
//  Created by Surya on 25/12/20.
//

import UIKit

class ForecastCollectionViewCell: UICollectionViewCell {

    //MARK: - IBOutlet Declaration
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var weatherStatusImage: UIImageView!
    @IBOutlet weak var weatherTypeLbl: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var tempLbl: UILabel!
    
    //MARK: - Type Methods
    static let cellIdentifier = "ForecastCollectionViewCell"
    static func nib() -> UINib{
         UINib(nibName: "ForecastCollectionViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.addAddCornerRadius()
    }
    
   
    //MARK: - Custom Methods
    func updateCell(withHourlyWeather weather: Hourly){
        let time = Helper.unixTodateConverter(withUnix: Double(weather.dt ?? 0), needFormat: .time12Hrs)
        timeLbl.text = time
        weatherTypeLbl.text = "\(weather.weather?[0].main?.capitalized ?? "")"
        tempLbl.text = "\(weather.temp ?? 0)° C"
        weatherStatusImage.image = Helper.weatherImageURL(weatherType: weather.weather?[0].main?.capitalized ?? "")
    }

}
