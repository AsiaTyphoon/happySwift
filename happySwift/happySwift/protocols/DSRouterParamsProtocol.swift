//
//  DSRouterParamsProtocol.swift
//  DSKit
//
//  Created by lotawei on 2020/10/26.
//  Copyright © 2020 成都东方盛行电子有限责任公司. All rights reserved.
//

import Foundation
@objc public protocol DSRouterParamsProtocol:NSObjectProtocol {
    func didrecieveParams(_ params:[String:Any])
}
