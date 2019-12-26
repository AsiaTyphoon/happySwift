//
//  extensionUIImage.swift
//  happySwift
//
//  Created by dfsx1 on 2018/9/17.
//  Copyright © 2018年 slardar. All rights reserved.
//

import Foundation
import UIKit

//MARK:-
public extension UIImage {
    
    
    /// 压缩图片大小
    /// - parameter scale : 压缩比例 0..1
    /// - returns : 压缩后的图片，压缩失败返回nil
    func exCompress(_ scale: CGFloat) -> UIImage? {
        guard let imgData = jpegData(compressionQuality: scale) else {
            return nil
        }
        return UIImage(data: imgData)
    }
    
    
    /// 修改图片尺寸
    /// - parameter size : 大小
    /// - returns : 修改后的图片，失败返回nil
    func exScaleToSize(_ size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(in: CGRect(origin: .zero, size: size))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    
    /// 等比例修改图片尺寸
    /// - parameter isWidth : 固定宽度(true),固定高度(false)
    /// - parameter value : 数值
    /// - returns : 等比缩放图片，失败返回nil
    func exScaleEqual(_ isWidth: Bool, value: CGFloat) -> UIImage? {
        var w: CGFloat = 0
        var h: CGFloat = 0
        if isWidth {
            w = value
            h = size.height / size.width * value
        } else {
            h = value
            w = size.width / size.height * value
        }
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(in: CGRect(origin: .zero, size: CGSize(width: w, height: h)))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    
}
