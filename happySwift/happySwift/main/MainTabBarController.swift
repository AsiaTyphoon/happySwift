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
        
        viewControllers = [homeVC]
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
