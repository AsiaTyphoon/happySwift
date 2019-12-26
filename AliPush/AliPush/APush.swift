//
//  AliPushManager.swift
//  AliPush
//
//  Created by dfsx1 on 2019/12/26.
//  Copyright © 2019 dfsx. All rights reserved.
//

import UIKit
import AliPushMap
import UserNotifications

/// 阿里推送appKey
public var AliPushAppKey: String {
    return "27842966"
}
/// 阿里推送appSecret
public var AliPushAppSecret: String {
    return "6689c88bfe25956bba7602882d86480e"
}

//MARK:-
/// 阿里推送管理器
open class APush: NSObject {
    
    static public let shared = APush()
}

//MARK:-
public extension APush {
    
    /// 阿里推送初始化
    static func configure(with appKey: String,
                          appSecret: String,
                          application: UIApplication,
                          launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        
        shared.asyncInit(with: appKey, appSecret: appSecret)
        shared.sendNotificationAck(with: launchOptions)
    }
    
    /// 向阿里云推送注册该设备的deviceToken
    /// - parameter deviceToken : 苹果APNs服务器返回的deviceToken
    /// - parameter completion : 完成回调
    /// - returns :
    static func registerDevice(with deviceToken: Data, completion: @escaping (_ isSuccess: Bool)->() ) {
        CloudPushSDK.registerDevice(deviceToken) { (result) in
            if let res = result, res.success {
                print("注册设备成功!")
                completion(true)
            } else {
                print("注册设备失败!: \(result?.error?.localizedDescription ?? "")")
                completion(false)
            }
        }
    }
    
    /// 设备ID
    static func deviceId() -> String? {
        return CloudPushSDK.getDeviceId()
    }
    
    
    /// 阿里推送初始化
    fileprivate func asyncInit(with appKey: String, appSecret: String) {
        CloudPushSDK.asyncInit(appKey, appSecret: appSecret) { (result) in
            if let res = result, res.success {
                print("阿里推送初始化成功!")
                print("阿里推送设备ID: \(CloudPushSDK.getDeviceId() ?? "")")
            } else {
                print("阿里推送初始化失败!: \(result?.error?.localizedDescription ?? "")")
            }
        }
    }
    
    /// 返回推送通知ACK到服务器
    fileprivate func sendNotificationAck(with launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        CloudPushSDK.sendNotificationAck(launchOptions)
    }
    
}
