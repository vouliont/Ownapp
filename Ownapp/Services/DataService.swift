//
//  DataService.swift
//  Ownapp
//
//  Created by Владислав on 1/29/19.
//  Copyright © 2019 vladporaiko. All rights reserved.
//

import Foundation

class DataService {
    static let instance = DataService()
    
    let menuItems: [MenuItem] = [
        MenuItem(name: "Home", vcId: "homeNavVC"),
        MenuItem(name: "About", vcId: "aboutNavVC"),
        MenuItem(name: "Photos", vcId: "photosNavVC"),
        MenuItem(name: "Map", vcId: "mapNavVC")
    ]
    
    func getMenuItems() -> [MenuItem] {
        return menuItems
    }
}
