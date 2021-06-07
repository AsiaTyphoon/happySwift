//
//  extensionNSObject.swift
//  happySwift
//
//  Created by dfsx1 on 2018/9/17.
//  Copyright © 2018年 slardar. All rights reserved.
//

import Foundation
import UIKit

//MARK:-
public extension NSObject {
    
    
    /// 获取对象属性
    /// - parameter  :
    /// - returns : 对象属性列表
    func exPropertyNames() -> [String] {
        
        var count: UInt32 = 0
        var list: [String] = []
        
        // 获取属性列表
        guard let proList = class_copyPropertyList(self.classForCoder, &count) else { return list }
        for i in 0..<Int(count) {
            let pro = proList[i]
            //获取属性的c字符串
            let proStr = property_getName(pro)
            //获取属性的String字符串
            if let proName = String(utf8String: proStr) {
                list.append(proName)
            }
        }
        free(proList)
        
        return list
    }
    
    /// 赋值对象属性
    /// - parameter dic : 字典
    /// - returns :
    func exCopyFrom(from dic: NSDictionary) -> Void {
        
        var count: UInt32 = 0
        
        let proList = class_copyPropertyList(self.classForCoder, &count)
        for i in 0..<Int(count) {
            
            let pro = proList![i]
            //获取属性的c字符串
            let proStr = property_getName(pro)
            //获取属性的String字符串
            let proName = String(utf8String: proStr)
            
            if let value = dic[proName!] {
                //居然真的返回了<null>
                if value is NSNull {
                    
                } else {
                    self.setValue(value, forKey: proName!)
                }
            }
        }
        free(proList)
    }
    
    
    /// GCD定时器倒计时
    /// - parameter timeInterval : 循环间隔时间
    /// - parameter repeatCount : 重复次数
    /// - parameter handler : 循环事件, 闭包参数： 1. timer， 2. 剩余执行次数
    /// - returns :
    func exDispatchTimer(timeInterval: Double, repeatCount:Int, handler:@escaping (DispatchSourceTimer?, Int)->()) {
        if repeatCount <= 0 {
            return
        }
        let timer = DispatchSource.makeTimerSource(flags: [], queue: DispatchQueue.main)
        var count = repeatCount
        timer.schedule(wallDeadline: .now(), repeating: timeInterval)
        timer.setEventHandler(handler: {
            count -= 1
            DispatchQueue.main.async {
                handler(timer, count)
            }
            if count == 0 {
                timer.cancel()
            }
        })
        timer.resume()
    }
    
    
    /// GCD定时器循环操作
    /// - parameter timeInterval : 循环间隔时间
    /// - parameter handler : 循环事件
    /// - returns :
    func exDispatchTimer(timeInterval: Double, handler:@escaping (DispatchSourceTimer?)->()) {
        let timer = DispatchSource.makeTimerSource(flags: [], queue: DispatchQueue.main)
        timer.schedule(deadline: .now(), repeating: timeInterval)
        timer.setEventHandler {
            DispatchQueue.main.async {
                handler(timer)
            }
        }
        timer.resume()
    }
    
    
    /// GCD延时操作
    /// - parameter after : 延迟的时间
    /// - parameter handler : 事件
    /// - returns :
    func exDispatchAfter(after: Double, handler:@escaping ()->()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + after) {
            handler()
        }
    }
}

//MARK:-
extension NSObject {
    
    /// 根据URL生成二维码图片
    public class func generate(from url: String) -> UIImage? {
        
        guard let data = url.data(using: .utf8) else {
            return nil
        }
        
        guard let filter = CIFilter.init(name: "CIQRCodeGenerator") else {
            return nil
        }
        
        let context = CIContext()
        filter.setValue(data, forKey: "inputMessage")
        let transform = CGAffineTransform(scaleX: 7, y: 7)
        guard let output = filter.outputImage?.transformed(by: transform) else {
            return nil
        }
        
        guard let cgImage = context.createCGImage(output, from: output.extent) else {
            return nil
        }
        return UIImage(cgImage: cgImage)
    }

}

//MARK:-
extension NSObject {
    
    /// 获取当前最顶部控制器
    public func exTopVC() -> UIViewController? {
        guard let rootViewController = UIApplication.shared.keyWindow?.rootViewController else { return nil }
        return topVC(for: rootViewController)
    }
    
    fileprivate func topVC(for rootViewController: UIViewController) -> UIViewController? {
        
        if let tabbarController = rootViewController as? UITabBarController {
            guard let selectedViewController = tabbarController.selectedViewController else { return nil }
            return topVC(for: selectedViewController)
        }
        else if let navigationController = rootViewController as? UINavigationController {
            guard let visibleViewController = navigationController.visibleViewController else { return nil }
            return topVC(for: visibleViewController)
        }
        else if let presentedController = rootViewController.presentedViewController {
            return topVC(for: presentedController)
        }
        else {
            return rootViewController
        }
    }
    
}
