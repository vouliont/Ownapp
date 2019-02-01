//
//  NavRootVCDelegate.swift
//  Ownapp
//
//  Created by Владислав on 1/30/19.
//  Copyright © 2019 vladporaiko. All rights reserved.
//

import UIKit

@objc
protocol NavRootVCDelegate {
    @objc optional func toggleSidebarMenu()
    @objc optional func closeSidebarMenu()
}
