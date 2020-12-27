//
//  Ext_WeatherDetailsVC+CollectionView.swift
//  Weather
//
//  Created by Surya on 27/12/20.
//

import UIKit

extension WeatherDetailsViewController: UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.hourlyWeather?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let dailyForecastCell = collectionView.dequeueReusableCell(withReuseIdentifier: ForecastCollectionViewCell.cellIdentifier, for: indexPath) as? ForecastCollectionViewCell else {
            return UICollectionViewCell()
        }
        dailyForecastCell.updateCell(withHourlyWeather: (self.hourlyWeather?[indexPath.row])!)
        return dailyForecastCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return  CGSize(width: 130, height: 170)
    }
    
    
}
