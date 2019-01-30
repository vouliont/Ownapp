//
//  NavRootVC.swift
//  Ownapp
//
//  Created by Владислав on 1/30/19.
//  Copyright © 2019 vladporaiko. All rights reserved.
//

import UIKit

class NavRootVC: UIViewController {
    
    var delegate: NavRootVCDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func setupView() {
        setBarButton()
        setBarTitle()
    }
    
    func setBarButton() {
        let barBtnImage = UIImage(named: "burger")
        let barBtn = UIBarButtonItem(image: barBtnImage, style: .plain, target: self, action: #selector(barBtnPressed))
        barBtn.tintColor = UIColor.black
        
        self.navigationItem.setLeftBarButton(barBtn, animated: true)
    }
    
    func setBarTitle() {
        
    }
    
    @objc func barBtnPressed() {
        delegate?.toggleSidebarMenu?()
    }

}
