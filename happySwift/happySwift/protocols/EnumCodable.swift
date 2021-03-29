//
//  EnumCodable.swift
//  core
//
//  Created by dfsx6 on 2020/10/13.
//  Copyright © 2020 jianglin. All rights reserved.
//

import Foundation

//MARK:- Codable解析未知枚举变量时，提供默认值
public protocol EnumCodable: RawRepresentable, Codable where RawValue: Codable {
    static var defaultCase: Self { get }
}

extension EnumCodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        do {
            let decoded = try container.decode(RawValue.self)
            self = Self.init(rawValue: decoded) ?? Self.defaultCase
        } catch {
            self = Self.defaultCase
        }
    }
}
