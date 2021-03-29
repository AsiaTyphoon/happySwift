//
//  DSPopupProtocol.swift
//  core
//
//  Created by dfsx6 on 2021/1/8.
//  Copyright © 2021 jianglin. All rights reserved.
//

import Foundation
import UIKit


//MARK:- window弹窗方向
public enum DSPopupDirection {
    case up
    case down
    case center(_ center: CGPoint? = nil)
}

//MARK:- window弹窗协议
public protocol DSPopupProtocol: NSObjectProtocol {
    
    var popWindow: UIWindow? { get }   // 容器window
    var popCoverView: UIView { get }   // 遮罩
    var popCoverColor: UIColor { get } // 遮罩颜色
    var popCoverFrame: CGRect { get } // 遮罩frame
    var enableCoverGesture: Bool { get }    // 是否响应遮照单击手势
    var popDuration: TimeInterval { get }    // 显示动画时长
    var popDirection: DSPopupDirection { get }   // 方向
    var popAnimations: (() -> Void, (Bool) -> Void)? { get }    // 自定义动画闭包
    var dismissAnimations: (() -> Void, (Bool) -> Void)? { get }    // 自定义动画闭包

    func popupOnWindow() // 显示
    func popupOnWindow(completion: (() -> Void)?) // 显示
    func dismissPopup() // 隐藏
    func dismissPopup(completion: (() -> Void)?) // 隐藏
}

//MARK:-
public extension DSPopupProtocol where Self: UIView {
    
    var popWindow: UIWindow? { return UIApplication.shared.keyWindow }
    var popCoverView: UIView {
        // 遮罩视图tag
        let popCoverViewTag = 100254
        var coverView = self.viewWithTag(popCoverViewTag)
        coverView = coverView ?? self.popWindow?.viewWithTag(popCoverViewTag)
        let targetView = coverView ?? UIView.init()
        targetView.tag = popCoverViewTag
        //print(targetView)
        return targetView
    }
    var popCoverColor: UIColor { return UIColor.black.withAlphaComponent(0.3) }
    var popCoverFrame: CGRect {
        return self.popWindow?.bounds ?? UIScreen.main.bounds
    }
    var enableCoverGesture: Bool { return true }
    var popDuration: TimeInterval { return 0.5 }
    var popDirection: DSPopupDirection { return .up }
    var popAnimations: (() -> Void, (Bool) -> Void)? { return nil }
    var dismissAnimations: (() -> Void, (Bool) -> Void)? { return nil }

    
    func popupOnWindow() {
        self.popupOnWindow(completion: nil)
    }
    
    func popupOnWindow(completion: (() -> Void)?) {
        
        guard let window = self.popWindow else { return }
        
        window.addSubview(self.popCoverView)
        self.popCoverView.alpha = 0
        self.popCoverView.frame = self.popCoverFrame
        self.popCoverView.backgroundColor = self.popCoverColor
        self.popCoverView.addSingleTapGesture { [weak self] (_) in
            guard let `self` = self else { return }
            self.dismissPopup()
        }
        window.addSubview(self)
        
        
        // 优先展示自定义动画
        if let animations = popAnimations {
            self.animateCustomAnimations(animations, completion: completion)
            return
        }
        
        // 默认动画实现
        switch self.popDirection {
        case .down:
            self.popDown(window: window, completion: completion)
        case .center(let center):
            self.popCenter(window: window, center: center, completion: completion)
        default:
            self.popUp(window: window, completion: completion)
        }
    }
    
    func dismissPopup() {
        self.dismissPopup(completion: nil)
    }

    
    func dismissPopup(completion: (() -> Void)?) {
        
        guard let window = self.popWindow else { return }
        
        let removeClosure: () -> Void = { [weak self] in
            guard let `self` = self else { return }
            self.isHidden = true
            self.removeFromSuperview()
            self.addSubview(self.popCoverView)
        }
        
        // 优先展示自定义动画
        if let animations = dismissAnimations {
            self.animateCustomAnimations(animations) {
                removeClosure()
                completion?()
            }
            return
        }

        
        switch self.popDirection {
        case .down:
            self.dismissDown(window: window) {
                removeClosure()
                completion?()
            }
        case .center(_):
            self.dismissCenter(window: window) {
                removeClosure()
                completion?()
            }
        default:
            self.dismissUp(window: window) {
                removeClosure()
                completion?()
            }
        }
    }
    
    //MARK:- custom
    /// 自定义动画
    fileprivate func animateCustomAnimations(_ animations: (() -> Void, (Bool) -> Void), completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: self.popDuration) {
            animations.0()
            self.popCoverView.alpha = 1
        } completion: { (isCompleted) in
            animations.1(isCompleted)
            completion?()
        }
    }

    
    //MARK:- up
    ///
    fileprivate func popUp(window: UIWindow, completion: (() -> Void)? = nil) {
        
        self.frame.origin.y = window.frame.height
        self.isHidden = false
        UIView.animate(withDuration: self.popDuration, animations: {
            self.popCoverView.alpha = 1
            self.frame.origin.y -= self.frame.height
        }) { (_) in
            completion?()
        }
    }

    ///
    fileprivate func dismissUp(window: UIWindow, completion: (() -> Void)? = nil) {
                
        UIView.animate(withDuration: self.popDuration, animations: {
            self.popCoverView.alpha = 0
            self.frame.origin.y = window.frame.height
        }) { (_) in
            completion?()
        }
    }


    //MARK:- down
    ///
    fileprivate func popDown(window: UIWindow, completion: (() -> Void)? = nil) {
        
        self.frame.origin.y = -self.frame.height
        self.isHidden = false
        UIView.animate(withDuration: self.popDuration, animations: {
            self.popCoverView.alpha = 1
            self.frame.origin.y += self.frame.height
        }) { (_) in
            completion?()
        }
    }
    
    ///
    fileprivate func dismissDown(window: UIWindow, completion: (() -> Void)? = nil) {
                
        UIView.animate(withDuration: self.popDuration, animations: {
            self.popCoverView.alpha = 0
            self.frame.origin.y = -self.frame.height
        }) { (_) in
            completion?()
        }
    }


    
    //MARK:- center
    ///
    fileprivate func popCenter(window: UIWindow, center: CGPoint? = nil, completion: (() -> Void)? = nil) {

        self.center = center ?? window.center
        self.isHidden = true
        UIView.animate(withDuration: self.popDuration, animations: {
            self.popCoverView.alpha = 1
            self.isHidden = false
        }) { (_) in
            completion?()
        }
    }
    
    ///
    fileprivate func dismissCenter(window: UIWindow, completion: (() -> Void)? = nil) {
        
        UIView.animate(withDuration: self.popDuration, animations: {
            self.popCoverView.alpha = 0
            self.isHidden = true
        }) { (_) in
            completion?()
        }
    }

}

fileprivate var singleTapClosurePointer = "singleTapClosurePointer"

//MARK:-
extension UIView {
    
    /// 手势闭包
    fileprivate var singleTapGestureClosure: ((_ sender: UITapGestureRecognizer) -> Void)? {
        get { return objc_getAssociatedObject(self, &singleTapClosurePointer) as? ((_ sender: UITapGestureRecognizer) -> Void) }
        set { objc_setAssociatedObject(self, &singleTapClosurePointer, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }

    public func addSingleTapGesture(_ closure: @escaping ((_ sender: UITapGestureRecognizer) -> Void)) {
        singleTapGestureClosure = closure
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(singleTapGestureAction(_:)))
        self.addGestureRecognizer(tap)
    }
    
    @objc fileprivate func singleTapGestureAction(_ recognizer: UITapGestureRecognizer) {
        singleTapGestureClosure?(recognizer)
    }
}
