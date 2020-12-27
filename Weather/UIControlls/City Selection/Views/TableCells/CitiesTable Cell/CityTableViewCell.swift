//
//  CityTableViewCell.swift
//  Weather
//
//  Created by Surya on 27/12/20.
//

import UIKit

class CityTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var weatherTypeLbl: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var tempLbl: UILabel!
    
    //MARK: - Type Methods
    static let cellIdentifier = "CityTableViewCell"
    static func nib() -> UINib{
        UINib(nibName: "CityTableViewCell", bundle: nil)
    }
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.addAddCornerRadius()
    }
}
