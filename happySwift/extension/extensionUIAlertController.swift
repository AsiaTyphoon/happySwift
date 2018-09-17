//
//  extensionUIAlertController.swift
//  happySwift
//
//  Created by dfsx1 on 2018/9/17.
//  Copyright © 2018年 slardar. All rights reserved.
//

import Foundation
import UIKit

extension UIAlertController {
    
    class func prompt(_ title: String) {
        prompt(title) {
            
        }
    }
    class func prompt(_ title: String, completion: @escaping ()->() ) {
        prompt(title, nil) {
            completion()
        }
    }
    class func prompt(_ title: String?, _ message: String?, completion: @escaping ()->() ) {
        DispatchQueue.main.async {
            
//            UIAlertController.alert(title, message: message, handler: { (_) in
//                completion()
//            })
        }
    }
    
    class func alert(_ title: String, completion: @escaping (() -> ()), cancel: @escaping (() -> ())) {
        alert(title, "确定", "取消", completion: {
            completion()
        }) {
            cancel()
        }
    }
    
    class func alert(_ title: String, _ okName: String, _ cancelName: String, completion: @escaping (() -> ()), cancel: @escaping (() -> ())) {
        DispatchQueue.main.async {
            let alertvc = UIAlertController(title: title, message: nil, preferredStyle: .alert)
            let action = UIAlertAction(title: okName, style: .default, handler: { (_) in
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
