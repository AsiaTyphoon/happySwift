//
//  UnitIphoneX.swift
//  happySwift
//
//  Created by dfsx1 on 2019/3/22.
//  Copyright © 2019 slardar. All rights reserved.
//

import Foundation
import UIKit


//TODO: IphoneX及以上机型判断
public var isUpperIphoneX: Bool {
    if UIDevice.current.userInterfaceIdiom != .phone { return false }
    //FIXME: iPhone X最低支持iOS11.0
    if #available(iOS 11.0, *) {
        if let keyWindow = UIApplication.shared.keyWindow, keyWindow.safeAreaInsets.bottom > 0.0 {
            return true
        }
    }
    return false
}
//TODO: 顶部安全区域高度(状态栏高度)
public var safeAreaInsetsTop: CGFloat {
    if #available(iOS 11.0, *) {
        if let keyWindow = UIApplication.shared.keyWindow {
            return keyWindow.safeAreaInsets.top
        }
    }
    return 20
}
//TODO: 底部安全区域高度
public var safeAreaInsetsBottom: CGFloat {
    if #available(iOS 11.0, *) {
        if let keyWindow = UIApplication.shared.keyWindow {
            return keyWindow.safeAreaInsets.bottom
        }
    }
    return 0
}
//TODO: 导航栏高度
public var safeAreaNavigationBar: CGFloat {
    return isUpperIphoneX ? 84 : 64
}
//TODO: tabbar高度
public var safeAreaTabbar: CGFloat {
    return 49 + safeAreaInsetsBottom
}
