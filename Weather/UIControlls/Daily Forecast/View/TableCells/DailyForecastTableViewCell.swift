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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        conainerView.addAddCornerRadius()
    }
    
}
