//
//  extensionString.swift
//  happySwift
//
//  Created by dfsx1 on 2018/9/17.
//  Copyright © 2018年 slardar. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    
    /// 获取文本尺寸
    /// - parameter size : 文本显示区域
    /// - parameter font : 文本大小
    /// - returns : 文本尺寸
    func size(_ size: CGSize, _ font: UIFont) -> CGSize {
        return (self as NSString).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font : font], context: nil).size
    }
}
