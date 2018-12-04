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
    
    /// 获得字符串的日期值
    ///
    /// - returns: 如果字符串能转换为日期，则返回日期值；否则返回nil
    public func dateValue() -> Date? {
        do {
            var date: Date? = nil
            let semaphore = DispatchSemaphore(value: 0)
            let detector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.date.rawValue)
            detector.enumerateMatches(in: self, options: NSRegularExpression.MatchingOptions(), range: NSRange(location: 0, length: self.lengthOfBytes(using: String.Encoding.utf8)), using: { (checkingResult, _, _) in
                date = checkingResult?.date
                semaphore.signal()
            })
            semaphore.wait()
            return date
        } catch _ {
            return nil
        }
    }
}
