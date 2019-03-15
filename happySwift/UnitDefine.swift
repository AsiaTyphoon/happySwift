//
//  UnitDefine.swift
//  happySwift
//
//  Created by dfsx1 on 2019/3/15.
//  Copyright © 2019 slardar. All rights reserved.
//

import Foundation
import UIKit

//MARK:-  IphoneX机型判断
public var isUpperIphoneX: Bool {
    
    if UIDevice.current.userInterfaceIdiom != .phone { return false }
    
    if #available(iOS 11.0, *) {
        if let keyWindow = UIApplication.shared.keyWindow, keyWindow.safeAreaInsets.bottom > 0.0 {
            return true
        }
    }
    
    return false
}
// 顶部安全区域高度
public var safeAreaInsetsTop: CGFloat {
    if isUpperIphoneX {
        if #available(iOS 11.0, *) {
            if let keyWindow = UIApplication.shared.keyWindow {
                return keyWindow.safeAreaInsets.top
            }
        }
    }
    return 0
}
// 底部安全区域高度
public var safeAreaInsetsBottom: CGFloat {
    if isUpperIphoneX {
        if #available(iOS 11.0, *) {
            if let keyWindow = UIApplication.shared.keyWindow {
                return keyWindow.safeAreaInsets.bottom
            }
        }
    }
    return 0
}
