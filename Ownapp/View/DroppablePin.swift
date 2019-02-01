//
//  DroppablePin.swift
//  Ownapp
//
//  Created by Владислав on 1/31/19.
//  Copyright © 2019 vladporaiko. All rights reserved.
//

import UIKit
import MapKit

class DroppablePin: NSObject, MKAnnotation {
    let coordinate: CLLocationCoordinate2D
    let identifier: String
    
    init(coordinate: CLLocationCoordinate2D, identifier: String) {
        self.coordinate = coordinate
        self.identifier = identifier
        super.init()
    }
}
