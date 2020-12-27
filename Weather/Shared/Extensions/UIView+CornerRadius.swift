//
//  UIView+CornerRadius.swift
//  Weather
//
//  Created by Surya on 27/12/20.
//

import UIKit

extension UIView{
    func addAddCornerRadius(){
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = false
    }
}
