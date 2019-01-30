//
//  MenuItemCell.swift
//  Ownapp
//
//  Created by Владислав on 1/29/19.
//  Copyright © 2019 vladporaiko. All rights reserved.
//

import UIKit

class MenuItemCell: UITableViewCell {

    // Outlets
    @IBOutlet weak var menuItemLbl: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupView(menuItem: MenuItem) {
        menuItemLbl.text = menuItem.name
    }

}
