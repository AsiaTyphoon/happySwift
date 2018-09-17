//
//  HSProgressView.swift
//  happySwift
//
//  Created by dfsx1 on 2018/9/14.
//  Copyright © 2018年 slardar. All rights reserved.
//

import UIKit

class HSProgressView: UIView {
    
    // 进度槽
    let sshapelayer = CAShapeLayer()
    var sstrokeColor = UIColor.gray
    var sfillColor = UIColor.clear
    
    
    // 进度条
    let shapeLayer = CAShapeLayer()
    var strokeColor = UIColor.red
    var fillColor = UIColor.clear
    
    
    // 进度条小圆点
    let imgViewDot = UIImageView()
    
    
    
    // 圆心
    var pcenter: CGPoint {
        get {
            return CGPoint(x: frame.width / 2, y: frame.height / 2)
        }
    }
    // 进度
    var pvalue: CGFloat = 0 {
        didSet {
            if pvalue > 1 { pvalue = 1 }
            else if pvalue < 0 { pvalue = 0 }
        }
    }
    // 半径
    var pradius: CGFloat = 0
    // 进度条宽
    var plineWidth: CGFloat = 5 {
        didSet {
            pradius = (MIN(frame.size.width, frame.size.height) - plineWidth) / 2
        }
    }
    
    
    //MARK:-
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        pradius = (MIN(frame.size.width, frame.size.height) - plineWidth) / 2
        addShapeLayer()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    deinit {
        print("-----deinit-----\(self.classForCoder)")
    }
    
    
    func addShapeLayer() {
        
        
        let start: CGFloat = 0
        let end: CGFloat = .pi * 2
        let point = CGPoint(x: frame.width / 2, y: frame.height / 2)
        
        
        sshapelayer.fillColor = UIColor.clear.cgColor
        sshapelayer.strokeColor = sstrokeColor.cgColor
        sshapelayer.lineWidth = plineWidth
        sshapelayer.path = UIBezierPath(arcCenter: point, radius: pradius, startAngle: start, endAngle: end, clockwise: true).cgPath
        sshapelayer.strokeStart = 0
        sshapelayer.strokeEnd = 1
        layer.addSublayer(sshapelayer)

        
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = strokeColor.cgColor
        shapeLayer.lineWidth = plineWidth
        let path = UIBezierPath(arcCenter: point, radius: pradius, startAngle: start, endAngle: end, clockwise: true)
        shapeLayer.path = path.cgPath
        shapeLayer.strokeStart = 0
        shapeLayer.strokeEnd = 0.5
        layer.addSublayer(shapeLayer)

        
        let dotW: CGFloat = 13
        imgViewDot.frame = CGRect(x: 0, y: 0, width: dotW, height: dotW)
        imgViewDot.layer.cornerRadius = dotW / 2
        imgViewDot.layer.position = cPoint(pcenter, 0, pradius, true)
        addSubview(imgViewDot)
        imgViewDot.backgroundColor = .green
    }
    
    
    //MARK:-  public function
    func progress(_ value: CGFloat) {
        
        
        let oldProgress: CGFloat = pvalue
        pvalue = value
        
        
        //进度条动画
        CATransaction.begin()
        CATransaction.setDisableActions(false)
        CATransaction.setAnimationTimingFunction(CAMediaTimingFunction(name:
            kCAMediaTimingFunctionEaseInEaseOut))
        CATransaction.setAnimationDuration(0.01)
        shapeLayer.strokeEnd = pvalue
        CATransaction.commit()
        
        
        //头部圆点动画
        let startAngle = angleToRadian(360 * oldProgress)
        let endAngle = angleToRadian(360 * pvalue)
        let clockWise = pvalue > oldProgress ? false : true
        let path2 = CGMutablePath()
        path2.addArc(center: pcenter,
                     radius: pradius,
                     startAngle: startAngle, endAngle: endAngle,
                     clockwise: clockWise, transform: transform)
        let orbit = CAKeyframeAnimation(keyPath:"position")
        orbit.duration = 0.01
        orbit.path = path2
        orbit.calculationMode = kCAAnimationPaced
        orbit.timingFunction =
            CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        orbit.rotationMode = kCAAnimationRotateAuto
        orbit.isRemovedOnCompletion = false
        orbit.fillMode = kCAFillModeForwards
        imgViewDot.layer.add(orbit,forKey:"Move")
    }
    
    
    /// 将角度转为弧度
    /// - parameter angle : 角度
    /// - returns : 弧度
    fileprivate func angleToRadian(_ angle: CGFloat) -> CGFloat {
        return CGFloat(angle / 180 * CGFloat.pi)
    }
    
    
    /// 获取圆周轨迹位置
    /// - parameter center : 圆心位置
    /// - parameter radius : 半径
    /// - parameter angle :  偏移角度
    /// - parameter clockwise :  顺逆时针
    /// - Returns : void
    func cPoint(_ center: CGPoint, _ angle: CGFloat, _ radius: CGFloat, _ clockwise: Bool) -> CGPoint {
        var tmpAngle = angle
        if clockwise {
            tmpAngle = 360 - angle
        }
        let t: Float = Float(tmpAngle) * Float.pi / 180
        let x2 = radius * CGFloat(cosf(t))
        let y2 = radius * CGFloat(sinf(t))
        return CGPoint(x: center.x + x2, y: center.y - y2)
    }
    
    
   
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
}
