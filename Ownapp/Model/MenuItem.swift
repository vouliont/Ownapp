//
//  MenuItem.swift
//  Ownapp
//
//  Created by Владислав on 1/29/19.
//  Copyright © 2019 vladporaiko. All rights reserved.
//

import Foundation

struct MenuItem {
    public private(set) var name: String!
    public private(set) var vcId: String!
    
    init(name: String, vcId: String) {
        self.name = name
        self.vcId = vcId
    }
}
