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

        initView()
    }
    
    func initView() {
        sidebarMenuVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "sidebarMenuVC") as? SidebarMenuVC
        view.addSubview(sidebarMenuVC.view)
        addChild(sidebarMenuVC)
        sidebarMenuVC.didMove(toParent: self)
        sidebarMenuVC.delegate = self
        sidebarMenuVC.menuView.selectRow(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .none)
        
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

extension ContainerVC: SidebarMenuVCDelegate {
    func selectedItem() {
        let selectedItemId = DataService.instance.selectedItem.vcId
        
        removeNavVC()
        addNewNavVC(withId: selectedItemId!)

        currentVC = currentNavVC.viewControllers.first as? NavRootVC
        currentVC.delegate = self

        toggleSidebarMenu()
    }
    
    func removeNavVC() {
        currentNavVC.view.removeFromSuperview()
        currentNavVC.removeFromParent()
    }
    
    func addNewNavVC(withId itemId: String) {
        currentNavVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: itemId) as? UINavigationController
        currentNavVC.view.frame.origin.x = currentNavVC.view.frame.size.width - 60
        currentNavVC.view.layer.shadowOpacity = 2
        self.view.addSubview(currentNavVC.view)
        self.addChild(currentNavVC)
        currentNavVC.didMove(toParent: self)
    }
}
