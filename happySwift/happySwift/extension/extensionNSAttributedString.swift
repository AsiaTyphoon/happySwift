//
//  extensionNSAttributedString.swift
//  happySwift
//
//  Created by dfsx1 on 2018/9/17.
//  Copyright © 2018年 slardar. All rights reserved.
//

import Foundation
import UIKit

//MARK:-
public extension NSAttributedString {
    
    /// 富文本转换为html
    /// - returns :
    func exConvertHtml() -> String? {
        do {
            let htmlData = try self.data(from: NSRange(location: 0, length: self.length), documentAttributes: [.documentType : NSAttributedString.DocumentType.html])
            return String(data: htmlData, encoding: .utf8)
        } catch {
            print("exConvertHtml: \(error)")
            return nil
        }
    }
}
