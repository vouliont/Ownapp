//
//  BorderedButton.swift
//  Ownapp
//
//  Created by Владислав on 2/1/19.
//  Copyright © 2019 vladporaiko. All rights reserved.
//

import UIKit

@IBDesignable
class BorderedButton: UIButton {

    @IBInspectable var borderRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = borderRadius
        }
    }

}
