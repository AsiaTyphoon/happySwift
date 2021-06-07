//
//  MainTabBarController.swift
//  happySwift
//
//  Created by ianin on 2020/4/13.
//  Copyright © 2020 slardar. All rights reserved.
//

import UIKit

class MainTabBarController: BaseTabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let homeVC = HomeViewController()
        homeVC.tabBarItem.title = "首页"
        homeVC.title = "首页"
        
        let vc = ViewController()
        vc.tabBarItem.title = "我的"
        
        viewControllers = [homeVC, vc]
    }
}

