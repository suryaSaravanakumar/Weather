//
//  Network Helper.swift
//  Weather
//
//  Created by Surya on 27/12/20.
//

import Foundation

class NetwokHelper{
    static let sharedInstance = NetwokHelper()
    private init (){}
    
    let session = URLSession.shared
    
    /**
     Call this function to use get API
     - Parameter endPoint: The URL Endpoint for the current API
     - Parameter completion: Completion closure contains the genric type of Codeable model
        - T  - Codeable Model (Pass your model here) to get the response from the API
     - Parameter failureBlock: Failure block with error
     */
    func callGetAPIWith<T: Codable>(with endPoint:String,
                                    responseType type: T.Type,
                                       completion: @escaping (T) -> (),
                                       failureBlock:@escaping (Error) ->()){
        guard  let url = URL(string: endPoint) else { return  }
        
        //FIXME: - Handle No Internet case
        let task = session.dataTask(with: url, completionHandler: { data, response, error in
            
            if error != nil {
                failureBlock(error!)
                return
            }
            do {
                let json = try JSONDecoder().decode(type.self, from: data! )
                completion(json)
            } catch {
                print("Error during JSON serialization: \(error.localizedDescription)")
            }
        })
        task.resume()
    }
}
