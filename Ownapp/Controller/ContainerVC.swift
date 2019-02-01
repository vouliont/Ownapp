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
    
    var viewControllers: [String: UINavigationController] = [:]

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
        
        if let menuItem = DataService.instance.getMenuItems().first {
            selectItem(with: menuItem.vcId)
            DataService.instance.selectedItem = menuItem
        }
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
    
    func closeSidebarMenu() {
        animateCurrentNavVCXPosition(targetPosition: 0)
        
        sidebarMenuIsOpened = false
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
    func selectedItem() { // todo pass here argument
        selectItem(with: DataService.instance.selectedItem.vcId)
        
        toggleSidebarMenu()
    }
    
    private func selectItem(with id: String) {
        removeNavVC()
        addNewNavVC(withId: id)
        
        currentVC = currentNavVC.viewControllers.first as? NavRootVC
        currentVC.delegate = self
    }
    
    func removeNavVC() {
        guard currentNavVC != nil else { return }
        currentNavVC.view.removeFromSuperview()
        currentNavVC.removeFromParent()
    }
    
    func addNewNavVC(withId itemId: String) {
        currentNavVC = viewControllers[itemId] ?? UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: itemId) as? UINavigationController
        self.viewControllers[itemId] = self.currentNavVC
        if self.viewControllers.count != 1 {
            self.currentNavVC.view.frame.origin.x = self.currentNavVC.view.frame.size.width - 60
            self.currentNavVC.view.layer.shadowOpacity = 2
        }
        self.addChild(self.currentNavVC)
        self.view.addSubview(self.currentNavVC.view)
        self.currentNavVC.didMove(toParent: self)
    }
}
