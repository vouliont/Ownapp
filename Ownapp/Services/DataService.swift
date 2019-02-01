//
//  DataService.swift
//  Ownapp
//
//  Created by Владислав on 1/29/19.
//  Copyright © 2019 vladporaiko. All rights reserved.
//

import Foundation
import Alamofire
import CoreLocation
import SwiftyJSON

class DataService {
    static let instance = DataService()
    
    var selectedItem: MenuItem!
    var weatherParams = [String: Any]()
    
    private let menuItems: [MenuItem] = [
        MenuItem(name: "Home", vcId: "homeNavVC"),
        MenuItem(name: "Weather", vcId: "weatherNavVC")
    ]
    
    func getMenuItems() -> [MenuItem] {
        return menuItems
    }
    
    func toFormWeatherParams(for location: CLLocationCoordinate2D, completion: @escaping CompletionHandler) {
        let lon = location.longitude
        let lat = location.latitude
        let url = "\(URL_API_WEATHER)&lon=\(lon)&lat=\(lat)"
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            if let error = response.error {
                debugPrint(error)
                completion(false)
            } else {
                if let data = response.data {
                    let json = try! JSON(data: data)
                    
                    self.weatherParams["title"] = json["weather"][0]["main"].stringValue
                    self.weatherParams["description"] = json["weather"][0]["description"].stringValue
                    self.weatherParams["temperature"] = json["main"]["temp"].intValue
                    self.weatherParams["humidity"] = json["main"]["humidity"].intValue
                    self.weatherParams["windSpeed"] = json["wind"]["speed"].intValue
                    self.weatherParams["image"] = json["weather"][0]["icon"].stringValue
                    
                    completion(true)
                }
            }
        }
    }
}
