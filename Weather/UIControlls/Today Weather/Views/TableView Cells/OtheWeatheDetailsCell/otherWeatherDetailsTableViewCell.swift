//
//  otherWeatherDetailsTableViewCell.swift
//  Weather
//
//  Created by Surya on 27/12/20.
//


import UIKit

class otherWeatherDetailsTableViewCell: UITableViewCell {

    //MARK: - IBOutlet Declaration
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var feelsLikeLbl: UILabel!
    @IBOutlet weak var humidityLbl: UILabel!
    @IBOutlet weak var visibilityLbl: UILabel!
    @IBOutlet weak var windLbl: UILabel!
    @IBOutlet weak var uvIndexLbl: UILabel!
    @IBOutlet weak var pressureLbl: UILabel!
    @IBOutlet weak var detailsContainerView: UIView!
    
    //MARK: - Type Methods
    static let cellIdentifier = "otherWeatherDetailsTableViewCell"
    static func nib() -> UINib{
         UINib(nibName: "otherWeatherDetailsTableViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        detailsContainerView.layer.cornerRadius = 4
        detailsContainerView.layer.masksToBounds = false
    }

   
    
}
