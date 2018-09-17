//
//  extensionNSObject.swift
//  happySwift
//
//  Created by dfsx1 on 2018/9/17.
//  Copyright © 2018年 slardar. All rights reserved.
//

import Foundation

extension NSObject {
    
    
    /// GCD定时器倒计时
    /// - parameter timeInterval : 循环间隔时间
    /// - parameter repeatCount : 重复次数
    /// - parameter handler : 循环事件, 闭包参数： 1. timer， 2. 剩余执行次数
    /// - returns :
    public func DispatchTimer(timeInterval: Double, repeatCount:Int, handler:@escaping (DispatchSourceTimer?, Int)->())
    {
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
    public func DispatchTimer(timeInterval: Double, handler:@escaping (DispatchSourceTimer?)->())
    {
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
    public func DispatchAfter(after: Double, handler:@escaping ()->())
    {
        DispatchQueue.main.asyncAfter(deadline: .now() + after) {
            handler()
        }
    }
}
