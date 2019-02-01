//
//  WeatherView.swift
//  Ownapp
//
//  Created by Владислав on 1/31/19.
//  Copyright © 2019 vladporaiko. All rights reserved.
//

import UIKit

class WeatherView: UIView {

    @IBOutlet weak var weatherTitle: UILabel!
    @IBOutlet weak var weatherDescription: UILabel!
    @IBOutlet weak var weatherTemp: UILabel!
    @IBOutlet weak var weatherHumidity: UILabel!
    @IBOutlet weak var weatherWindSpeed: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    
    func setupView(title: String, description: String, temperature: Int, humidity: Int, windSpeed: Int, image: UIImage) {
        self.weatherTitle.text = title
        self.weatherDescription.text = description
        self.weatherTemp.text = "\(temperature)°C"
        self.weatherHumidity.text = "\(humidity)%"
        self.weatherWindSpeed.text = "\(windSpeed) m/s"
        self.weatherImage.image = image
    }

}
