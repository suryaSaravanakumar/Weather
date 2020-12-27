//
//  ForecastCollectionHolderTableViewCell.swift
//  Weather
//
//  Created by Surya on 27/12/20.
//


import UIKit

class ForecastCollectionHolderTableViewCell: UITableViewCell {

    //MARK: - IBOutlet Declaration
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.reloadData()
    }

    //MARK: - Type Methods
    static let cellIdentifier = "ForecastCollectionHolderTableViewCell"
    static func nib() -> UINib{
         UINib(nibName: "ForecastCollectionHolderTableViewCell", bundle: nil)
    }
    
}
