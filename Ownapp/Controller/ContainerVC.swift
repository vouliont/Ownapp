//
//  ContainerVC.swift
//  Ownapp
//
//  Created by Владислав on 1/29/19.
//  Copyright © 2019 vladporaiko. All rights reserved.
//

import UIKit

class ContainerVC: UIViewController {
    
    // Variables
    var sidebarMenuVC: SidebarMenuVC!
    var currentNavVC: UINavigationController!
    var currentVC: NavRootVC!
    var sidebarMenuIsOpened = false
    
    var barButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()

        sidebarMenuVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "sidebarMenuVC") as? SidebarMenuVC
        view.addSubview(sidebarMenuVC.view)
        addChild(sidebarMenuVC)
        sidebarMenuVC.didMove(toParent: self)
        
        currentNavVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "homeNavVC") as? UINavigationController
        view.addSubview(currentNavVC.view)
        addChild(currentNavVC)
        currentNavVC.didMove(toParent: self)
        
        currentVC = currentNavVC.viewControllers.first as? NavRootVC
        currentVC.delegate = self
        
    }

}

extension ContainerVC: NavRootVCDelegate {
    func toggleSidebarMenu() {
        if sidebarMenuIsOpened {
            animateCurrentNavVCXPosition(targetPosition: 0)
        } else {
            let targetPosition = self.currentNavVC.view.frame.size.width - 60
            animateCurrentNavVCXPosition(targetPosition: targetPosition)
        }
        
        sidebarMenuIsOpened = !sidebarMenuIsOpened
    }
    
    func animateCurrentNavVCXPosition(targetPosition: CGFloat) {
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 0,
                       options: .curveEaseInOut,
                       animations: {
                        self.currentNavVC.view.frame.origin.x = targetPosition
                        self.currentNavVC.view.layer.shadowOpacity = 2
        }, completion: nil)
    }
}
