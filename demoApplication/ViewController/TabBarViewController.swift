//
//  tabBarViewController.swift
//  demoApplication
//
//  Created by Macbook  on 8/19/20.
//  Copyright © 2020 mtvd. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard
            let vc1 = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "vc1") as? FirstViewController,
            let vc2 = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "vc2") as? SecondViewController,
        let vc3 = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "vc3") as? ThirdViewController
        else { return }
        
        let firstVC = FirstViewController()
        firstVC.tabBarItem.image = #imageLiteral(resourceName: "burger")
        let firstNav = UINavigationController(rootViewController: vc1)
        firstNav.tabBarItem = UITabBarItem(tabBarSystemItem: .featured, tag: 0)
        
        let secondVC = SecondViewController()
        secondVC.tabBarItem.image = #imageLiteral(resourceName: "burger")
        let secondNav = UINavigationController(rootViewController: vc2)
        secondNav.tabBarItem = UITabBarItem(tabBarSystemItem: .featured, tag: 1)
        
        let thirdVC = ThirdViewController()
        thirdVC.tabBarItem.image = #imageLiteral(resourceName: "burger")
        let thirdNav = UINavigationController(rootViewController: vc3)
        thirdNav.tabBarItem = UITabBarItem(tabBarSystemItem: .featured, tag: 2)
        
        self.viewControllers = [firstNav, secondNav, thirdNav]
    }
}
