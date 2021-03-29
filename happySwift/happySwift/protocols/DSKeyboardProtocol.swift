//
//  DSKeyboardProtocol.swift
//  DSKit
//
//  Created by dfsx6 on 2020/12/11.
//  Copyright © 2020 成都东方盛行电子有限责任公司. All rights reserved.
//

import Foundation
import UIKit

//MARK:-
public protocol DSKeyboardProtocol: NSObjectProtocol {
        
    var responder: UIResponder { get }
    func showKeyboard()
    func dismissKeyboard()
    func keyboardDidShow()
    func keyboardDidHide()
}

//MARK:-
public extension DSKeyboardProtocol where Self: UIView {
    
    func showKeyboard() {
        let coverView = gestureView()
        UIApplication.shared.keyWindow?.addSubview(coverView)
        coverView.addObserver()
        self.responder.becomeFirstResponder()
    }
    
    func dismissKeyboard() {
        let coverView = gestureView()
        self.responder.resignFirstResponder()
        coverView.removeObserver()
        coverView.removeFromSuperview()
    }
    
    func keyboardDidShow() {
        
    }
    
    func keyboardDidHide() {
        
    }
    
    fileprivate func gestureView() -> DSKeyboardGestureView {
        let gestureView = self.superview as? DSKeyboardGestureView ?? DSKeyboardGestureView.init(delegate: self)
        return gestureView
    }
}

//MARK:-
fileprivate class DSKeyboardGestureView: UIView {
    
    fileprivate var subView: UIView?
    fileprivate var subViewH: CGFloat {
        return self.subView?.frame.height ?? 0.0
    }
    fileprivate var keyboardProtocol: DSKeyboardProtocol?
    
    override private init(frame: CGRect) {
        super.init(frame: frame)
        
        self.alpha = 0
        self.frame = UIScreen.main.bounds
        self.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap(_:))))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    convenience init(delegate: DSKeyboardProtocol) {
        self.init()
        
        if let input = delegate as? UIView {
            input.frame.origin.x = 0
            input.frame.origin.y = UIScreen.main.bounds.height
            addSubview(input)
            
            self.subView = input
        }
        self.keyboardProtocol = delegate
    }
        
    func addObserver() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrame(_:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow(_:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidHide(_:)), name: UIResponder.keyboardDidHideNotification, object: nil)

    }
    
    func removeObserver() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidHideNotification, object: nil)

    }
    
    @objc fileprivate func keyboardWillChangeFrame(_ notification: Notification) {
        
        //动画时长
        guard let duration = (notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as AnyObject).doubleValue else { return }
        //guard let frameBegin = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as AnyObject).cgRectValue else { return }
        guard let frameEnd = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as AnyObject).cgRectValue else { return }
        
        self.inputView?.layoutIfNeeded()
        self.inputView?.setNeedsDisplay()
        
        UIView.animate(withDuration: duration, animations: {
            if frameEnd.origin.y == UIScreen.main.bounds.height {
                self.subView?.frame.origin.y = frameEnd.origin.y
                self.alpha = 0
            } else {
                self.subView?.frame.origin.y = frameEnd.origin.y-self.subViewH
                self.alpha = 1
            }
        }) { (_) in
            
        }
        
    }
    
    @objc fileprivate func keyboardWillShow(_ notification: Notification) {
        //do something
    }
    
    @objc fileprivate func keyboardWillHide(_ notification: Notification) {
        //do something
    }
    
    @objc fileprivate func keyboardDidShow(_ notification: Notification) {
        //do something
        print("keyboardDidShow")
        self.keyboardProtocol?.keyboardDidShow()

    }
    
    @objc fileprivate func keyboardDidHide(_ notification: Notification) {
        //do something
        print("keyboardDidHide")
        self.keyboardProtocol?.keyboardDidHide()

    }
    
    @objc fileprivate func tap(_ sender: Any?) {
        self.keyboardProtocol?.dismissKeyboard()
    }
}

