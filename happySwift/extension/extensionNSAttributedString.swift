//
//  extensionNSAttributedString.swift
//  happySwift
//
//  Created by dfsx1 on 2018/9/17.
//  Copyright © 2018年 slardar. All rights reserved.
//

import Foundation
import UIKit

extension NSAttributedString {
    
    
    /// 富文本 -> html文本
    func toHtml() -> String? {
        do {
            let htmlData = try self.data(from: NSRange(location: 0, length: self.length), documentAttributes: [.documentType : NSAttributedString.DocumentType.html])
            return String(data: htmlData, encoding: .utf8)
        } catch {
            print("toHtml_error:\(error)")
            return nil
        }
    }
}
