//
//  extensionString.swift
//  happySwift
//
//  Created by dfsx1 on 2018/9/17.
//  Copyright © 2018年 slardar. All rights reserved.
//

import Foundation
import UIKit

//MARK:-
public extension String {
    
    /// 获取文本尺寸
    /// - parameter fontSize : 文本字体大小
    /// - returns : 文本尺寸
    func exSize(for fontSize: CGFloat) -> CGSize {
        return exSize(for: UIFont.systemFont(ofSize: fontSize))
    }
    
    /// 获取文本尺寸
    /// - parameter font : 文本字体
    /// - returns : 文本尺寸
    func exSize(for font: UIFont) -> CGSize {
        let size = CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
        return exSize(in: size, font: font)
    }
    
    /// 获取文本在指定区域内的尺寸
    /// - parameter size : 文本显示区域
    /// - parameter font : 文本字体大小
    /// - returns : 文本尺寸
    func exSize(in size: CGSize, fontSize: CGFloat) -> CGSize {
        return exSize(in: size, font: UIFont.systemFont(ofSize: fontSize))
    }
    
    /// 获取文本在指定区域内的尺寸
    /// - parameter size : 文本显示区域
    /// - parameter font : 文本字体
    /// - returns : 文本尺寸
    func exSize(in size: CGSize, font: UIFont) -> CGSize {
        if size == .zero { return size }
        let options: NSStringDrawingOptions = .usesLineFragmentOrigin
        let attributes: [NSAttributedString.Key : Any] = [.font : font]
        return (self as NSString).boundingRect(with: size, options: options, attributes: attributes, context: nil).size
    }
}

//MARK:-
public extension String {
    /// 获得字符串的日期值
    ///
    /// - returns: 如果字符串能转换为日期，则返回日期值；否则返回nil
    func exDateValue() -> Date? {
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
