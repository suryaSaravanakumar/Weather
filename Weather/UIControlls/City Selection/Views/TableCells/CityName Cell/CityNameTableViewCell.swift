//
//  CityNameTableViewCell.swift
//  Weather
//
//  Created by Surya on 27/12/20.
//

import UIKit

class CityNameTableViewCell: UITableViewCell {

    @IBOutlet weak var cityNameLbl: UILabel!
   
    //MARK: - Type Methods
    static let cellIdentifier = "CityNameTableViewCell"
    
    static func nib() -> UINib{
        UINib(nibName: "CityNameTableViewCell", bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    
    }
}
