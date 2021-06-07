//
//  extensionUIAlertController.swift
//  happySwift
//
//  Created by dfsx1 on 2018/9/17.
//  Copyright © 2018年 slardar. All rights reserved.
//

import Foundation
import UIKit

//MARK:-
public extension UIAlertController {
    

    /// 确认取消系统弹窗
    /// - parameter title : 标题
    /// - parameter completion : 确认回调
    /// - parameter cancel : 取消回调
    /// - returns :
    class func alert(_ title: String, completion: @escaping (() -> ()), cancel: @escaping (() -> ())) {
        alert(with: title, defaultName: "确认", cancelName: "取消", completion: completion, cancel: cancel)
    }

    
    /// 系统弹窗
    /// - parameter title : 标题
    /// - parameter defaultName : 确认
    /// - parameter cancelName : 取消
    /// - parameter completion : 确认回调
    /// - parameter cancel : 取消回调
    /// - returns :
    class func alert(with title: String, defaultName: String, cancelName: String, completion: @escaping (() -> ()), cancel: @escaping (() -> ())) {
        DispatchQueue.main.async {
            let alertvc = UIAlertController(title: title, message: nil, preferredStyle: .alert)
            let action = UIAlertAction(title: defaultName, style: .default, handler: { (_) in
                completion()
            })
            let cancelAction = UIAlertAction(title: cancelName, style: .cancel, handler: { (_) in
                cancel()
            })
            alertvc.addAction(action)
            alertvc.addAction(cancelAction)
            UIApplication.shared.keyWindow?.rootViewController?.present(alertvc, animated: true, completion: nil)
        }
    }
}
