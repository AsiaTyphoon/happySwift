//
//  extensionUIView.swift
//  happySwift
//
//  Created by dfsx1 on 2018/9/14.
//  Copyright © 2018年 slardar. All rights reserved.
//

import Foundation
import UIKit

//MARK:-
public extension UIView {
    
    /// 获取view的快照图片
    /// - returns : view截图，失败返回nil
    func exSnapshot() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, 0)
        guard let context = UIGraphicsGetCurrentContext() else {
            UIGraphicsEndImageContext()
            return nil
        }
        layer.render(in: context)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    
    /// 生成指定尺寸的纯色图片
    /// - parameter color : 颜色
    /// - parameter size : 大小
    /// - returns : 纯色图片，失败返回nil
    func exCreateImageWithColor(_ color: UIColor, _ size: CGSize) -> UIImage? {
        if size == .zero { return nil }
        UIGraphicsBeginImageContext(size)
        guard let context = UIGraphicsGetCurrentContext() else {
            UIGraphicsEndImageContext()
            return nil
        }
        context.setFillColor(color.cgColor)
        context.fill(CGRect(origin: .zero, size: size))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
