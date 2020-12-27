//
//  DataBaseHelper.swift
//  Weather
//
//  Created by Surya on 27/12/20.
//

import UIKit
import CoreData

struct   DataBaseHelper{
    static let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    static func saveCoreDataContext (){
            do{
                try context.save()
            } catch {
                print("error saving coredata: \(error)")
            }
    }
    
    static func  loadCityDataFromDB() -> [City] {
        let request: NSFetchRequest<City> = City.fetchRequest()
        do{
            return try context.fetch(request)
        } catch {
            print("error fetching coredata: \(error)")
        }
        return [City]()
    }
}
    

