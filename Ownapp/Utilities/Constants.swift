//
//  Constants.swift
//  Ownapp
//
//  Created by Владислав on 1/31/19.
//  Copyright © 2019 vladporaiko. All rights reserved.
//

import Foundation

typealias CompletionHandler = (_ success: Bool) -> ()

let TOKEN_FOR_WEATHER = "af70ae567a9f4cc672ff78c5a2f91418"
let URL_API_WEATHER = "https://api.openweathermap.org/data/2.5/weather?appid=\(TOKEN_FOR_WEATHER)&units=metric"
