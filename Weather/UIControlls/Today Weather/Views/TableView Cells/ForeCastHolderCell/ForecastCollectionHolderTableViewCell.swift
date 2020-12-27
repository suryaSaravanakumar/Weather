//
//  ForecastCollectionHolderTableViewCell.swift
//  Weather
//
//  Created by Surya on 27/12/20.
//


import UIKit

class ForecastCollectionHolderTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    static var cellIdentifier = "ForecastCollectionHolderTableViewCell"
    
    static func nib() -> UINib{
         UINib(nibName: "ForecastCollectionHolderTableViewCell", bundle: nil)
    }
    

}
