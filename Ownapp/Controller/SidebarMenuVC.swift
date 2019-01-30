//
//  SidebarMenuVC.swift
//  Ownapp
//
//  Created by Владислав on 1/29/19.
//  Copyright © 2019 vladporaiko. All rights reserved.
//

import UIKit

class SidebarMenuVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // Outlets
    @IBOutlet weak var menuView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        menuView.delegate = self
        menuView.dataSource = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataService.instance.getMenuItems().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "menuItemCell", for: indexPath) as? MenuItemCell {
            let menuItem = DataService.instance.getMenuItems()[indexPath.row]
            cell.setupView(menuItem: menuItem)
            
            return cell
        }
        
        return MenuItemCell()
    }

}
