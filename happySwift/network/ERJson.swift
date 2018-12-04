//
//  ERJson.swift
//  happySwift
//
//  Created by dfsx1 on 2018/12/4.
//  Copyright © 2018年 slardar. All rights reserved.
//

import UIKit

/// 错误代码
public enum ErrorCode: Int {
    
    /// JSON error start
    case jsonObjectIsNil = 0x8000
    case jsonFieldMissing
    case jsonTypeMissMatch
}

class ERJson: NSObject {

    /// 确保给定对象是T类型
    ///
    /// - parameter object: 待分析的对象
    /// - parameter asType: object鉴定类型
    /// - parameter error: 返回的错误
    /// - returns: 如果给定对象是T类型，则返回T类型的对象;否则返回nil
    open static func require<T>(_ object: Any?, asType: T.Type, error: NSErrorPointer) -> T? {
        if let noneNilObject = object {
            if let objectWithType = noneNilObject as? T {
                return objectWithType
            } else {
                error?.pointee = NSError(domain:"对象不是\(T.self)类型", code: ErrorCode.jsonTypeMissMatch.rawValue, userInfo: nil)
            }
        } else {
            error?.pointee = NSError(domain:"对象为nil", code: ErrorCode.jsonObjectIsNil.rawValue, userInfo: nil)
        }
        return nil
    }
    
    /// 确保给定字段在字典中存在且是指定类型
    ///
    /// - parameter dict: 给定字典
    /// - parameter field: 字段名称
    /// - parameter asType: object鉴定类型
    /// - parameter error: 返回的错误
    /// - returns: 如果给定对象是T类型，则返回T类型的对象;否则返回nil
    open static func require<T>(_ dict: NSDictionary, field: String, asType: T.Type, error: NSErrorPointer) -> T? {
        if let object = dict.object(forKey: field) {
            if let objectWithType = object as? T {
                return objectWithType
            } else {
                if object is NSNull {
                    if T.self == NSArray.self {
                        return NSArray() as? T
                    } else if T.self == String.self {
                        return String() as? T
                    } else if T.self == NSString.self {
                        return NSString() as? T
                    } else if T.self == NSDictionary.self {
                        return NSDictionary() as? T
                    }
                } else if let stringObject = object as? String {
                    var convertedObject: Any? = nil
                    if T.self == Int.self {
                        convertedObject = Int(stringObject)
                    } else if T.self == UInt.self {
                        convertedObject = UInt(stringObject)
                    } else if T.self == Float.self {
                        convertedObject = Float(stringObject)
                    } else if T.self == Double.self {
                        convertedObject = Double(stringObject)
                    } else if T.self == Date.self {
                        convertedObject = stringObject.dateValue()
                    }
                    
                    if nil != convertedObject {
                        return (convertedObject as? T)
                    }
                }
                error?.pointee = NSError(domain:"字段\(field)不是\(T.self)类型", code: ErrorCode.jsonTypeMissMatch.rawValue, userInfo: nil)
            }
        } else {
            error?.pointee = NSError(domain:"缺少字段\(field)", code: ErrorCode.jsonTypeMissMatch.rawValue, userInfo: nil)
        }
        return nil
    }
}
