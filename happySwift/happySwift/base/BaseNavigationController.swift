//
//  BaseNavigationController.swift
//  happySwift
//
//  Created by ianin on 2020/4/13.
//  Copyright © 2020 slardar. All rights reserved.
//

import UIKit

open class BaseNavigationController: UINavigationController {

    
    open override func viewDidLoad() {
        super.viewDidLoad()

        // 隐藏导航栏，使用自定义导航栏
        isNavigationBarHidden = true
    }

}
