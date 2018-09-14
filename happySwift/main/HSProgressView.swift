//
//  HSProgressView.swift
//  happySwift
//
//  Created by dfsx1 on 2018/9/14.
//  Copyright © 2018年 slardar. All rights reserved.
//

import UIKit

class HSProgressView: UIView {
    
    
    struct RBInfo {
        
        //透明色
        static let clearColor = UIColor.clear
        //进度条宽度
        static let lineWidth: CGFloat = 6
        //进度条半径
        static let lineRadius: CGFloat = 20
        //进度条颜色
        static let lineColor = UIColor(red: 63.0 / 255.0, green: 166.0 / 255.0, blue: 246.0 / 255.0, alpha: 1.0)
        //上传失败后进度条颜色
        static let lineColorFailed = UIColor(red: 150.0 / 255.0, green: 150.0 / 255.0, blue: 150.0 / 255.0, alpha: 1.0)
        //原点半径
        static let dotRadius: CGFloat = 13 / 2
        //暂不上传背景色
        static let btnBgColorCancel = UIColor(red: 230.0 / 255.0, green: 232.0 / 255.0, blue: 245.0 / 255.0, alpha: 1.0)
        //暂不上传字体颜色
        static let btnColorCancel = UIColor(red: 137.0 / 255.0, green: 137.0 / 255.0, blue: 137.0 / 255.0, alpha: 1.0)
        //重新上传背景色
        static let btnBgColorOk = UIColor(red: 217.0 / 255.0, green: 219.0 / 255.0, blue: 234.0 / 255.0, alpha: 1.0)
        //重新上传字体颜色
        static let btnColorOk = UIColor(red: 51.0 / 255.0, green: 51.0 / 255.0, blue: 51.0 / 255.0, alpha: 1.0)
    }
    
    let hwRatio: CGFloat = 294 / 267
    
    // 进度槽
    let sshapelayer = CAShapeLayer()
    var sstrokeColor = UIColor.gray
    
    
    // 进度条
    let shapeLayer = CAShapeLayer()
    let imgViewDot = UIImageView()  //进度条小圆点
    var showCancel = false
    //圆心
    var pcenter: CGPoint {
        get {
            return CGPoint(x: frame.width / 2, y: frame.height / 2)
        }
    }
    //进度
    var pvalue: CGFloat = 0 {
        didSet {
            if pvalue > 1 { pvalue = 1 }
            else if pvalue < 0 { pvalue = 0 }
        }
    }
    var pradius: CGFloat = 0   //半径
    //进度槽宽
    var plineWidth: CGFloat = 5 {
        didSet {
            pradius = (MIN(frame.size.width, frame.size.height) - plineWidth) / 2
        }
    }
    var count: CGFloat = 0
    
    deinit {
        print("-----deinit-----\(self.classForCoder)")
    }
    //MARK:-  init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        pradius = (MIN(frame.size.width, frame.size.height) - plineWidth) / 2
        
        
        
//        testCAShapeLayer()
        addShapeLayer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        shapeLayer.strokeColor = RBInfo.lineColor.cgColor
        shapeLayer.lineWidth = plineWidth
        let path = UIBezierPath(arcCenter: point, radius: pradius, startAngle: start, endAngle: end, clockwise: true)
        shapeLayer.path = path.cgPath
        shapeLayer.strokeStart = 0
        shapeLayer.strokeEnd = 0.5
        layer.addSublayer(shapeLayer)

        
        let dotW: CGFloat = 13
        imgViewDot.frame = CGRect(x: 0, y: 0, width: dotW, height: dotW)
        imgViewDot.layer.cornerRadius = dotW / 2
        imgViewDot.clipsToBounds = true
        //        imgViewDot.isHidden = true
        //        imgViewDot.image = UIImage(named: "icon_ellipse_1")
        
        
        let dotPath = UIBezierPath(ovalIn:
            CGRect(x: 0,y: 0, width: RBInfo.dotRadius * 2, height: RBInfo.dotRadius * 2)).cgPath
        let arc = CAShapeLayer()
        arc.lineWidth = 0
        arc.path = dotPath
        arc.strokeStart = 0
        arc.strokeEnd = 1
        arc.strokeColor = UIColor(red: 250.0 / 255.0, green: 93.0 / 255.0, blue: 26.0 / 255.0, alpha: 1.0).cgColor
        arc.fillColor = UIColor(red: 250.0 / 255.0, green: 93.0 / 255.0, blue: 26.0 / 255.0, alpha: 1.0).cgColor
        arc.shadowColor = UIColor.black.cgColor
        arc.shadowRadius = 5.0
        arc.shadowOpacity = 0.5
        arc.shadowOffset = CGSize.zero
        imgViewDot.layer.addSublayer(arc)
        imgViewDot.layer.position = cPoint(pcenter, 0, RBInfo.lineRadius, true)
        addSubview(imgViewDot)
        
        let imgIcon = UIImageView(image: UIImage(named: "icon_ellipse_1"))
        imgIcon.frame = CGRect(x: 0, y: 0, width: dotW, height: dotW)
        imgViewDot.addSubview(imgIcon)
        imgViewDot.backgroundColor = .green
    }
    
    
    
    
    
    
    //MARK:-  环形进度框
//    func testCAShapeLayer() {
//
//        let start: CGFloat = 0
//        let end: CGFloat = .pi * 2
//        let point = CGPoint(x: frame.width / 2, y: frame.height / 2)
//        shapeLayer.fillColor = UIColor.clear.cgColor
//        shapeLayer.strokeColor = RBInfo.lineColor.cgColor
//        shapeLayer.lineWidth = 6
//        layer.addSublayer(shapeLayer)
//        let path = UIBezierPath(arcCenter: point, radius: pradius, startAngle: start, endAngle: end, clockwise: true)
//        shapeLayer.path = path.cgPath
//        shapeLayer.strokeStart = 0
//        shapeLayer.strokeEnd = 0.5
//
//
//        let dotW: CGFloat = 13
//        imgViewDot.frame = CGRect(x: 0, y: 0, width: dotW, height: dotW)
//        imgViewDot.layer.cornerRadius = dotW / 2
//        imgViewDot.clipsToBounds = true
////        imgViewDot.isHidden = true
//        //        imgViewDot.image = UIImage(named: "icon_ellipse_1")
//
//
//        let dotPath = UIBezierPath(ovalIn:
//            CGRect(x: 0,y: 0, width: RBInfo.dotRadius * 2, height: RBInfo.dotRadius * 2)).cgPath
//        let arc = CAShapeLayer()
//        arc.lineWidth = 0
//        arc.path = dotPath
//        arc.strokeStart = 0
//        arc.strokeEnd = 1
//        arc.strokeColor = UIColor(red: 250.0 / 255.0, green: 93.0 / 255.0, blue: 26.0 / 255.0, alpha: 1.0).cgColor
//        arc.fillColor = UIColor(red: 250.0 / 255.0, green: 93.0 / 255.0, blue: 26.0 / 255.0, alpha: 1.0).cgColor
//        arc.shadowColor = UIColor.black.cgColor
//        arc.shadowRadius = 5.0
//        arc.shadowOpacity = 0.5
//        arc.shadowOffset = CGSize.zero
//        imgViewDot.layer.addSublayer(arc)
//        imgViewDot.layer.position = cPoint(pcenter, 0, RBInfo.lineRadius, true)
//        addSubview(imgViewDot)
//
//        let imgIcon = UIImageView(image: UIImage(named: "icon_ellipse_1"))
//        imgIcon.frame = CGRect(x: 0, y: 0, width: dotW, height: dotW)
//        imgViewDot.addSubview(imgIcon)
//        imgViewDot.backgroundColor = .green
//
//    }
    
    
    
    //MARK:-  public function
    func progress(_ value: CGFloat) {
        
        shapeLayer.strokeColor = RBInfo.lineColor.cgColor
//        center = CGPoint(x: viewBackground.frame.width / 2, y: viewBackground.frame.height / 2)
        
        
        let oldProgress: CGFloat = pvalue
        pvalue = value
        
        
        //进度条动画
        CATransaction.begin()
        CATransaction.setDisableActions(false)
        CATransaction.setAnimationTimingFunction(CAMediaTimingFunction(name:
            kCAMediaTimingFunctionEaseInEaseOut))
        CATransaction.setAnimationDuration(0)
        shapeLayer.strokeEnd = pvalue
        CATransaction.commit()
        
        //头部圆点动画
        if pvalue == 0 {
            imgViewDot.layer.position = cPoint(pcenter, 0, RBInfo.lineRadius, true)
        } else if pvalue == 1 {
            imgViewDot.layer.position = cPoint(pcenter, 0, RBInfo.lineRadius, true)
        } else {
            let startAngle = angleToRadian(360 * oldProgress)
            let endAngle = angleToRadian(360 * pvalue)
            let clockWise = pvalue > oldProgress ? false : true
            let path2 = CGMutablePath()
            path2.addArc(center: pcenter,
                         radius: RBInfo.lineRadius,
                         startAngle: startAngle, endAngle: endAngle,
                         clockwise: clockWise, transform: transform)
            
            let orbit = CAKeyframeAnimation(keyPath:"position")
            orbit.duration = 0
            orbit.path = path2
            orbit.calculationMode = kCAAnimationPaced
            orbit.timingFunction =
                CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            orbit.rotationMode = kCAAnimationRotateAuto
            orbit.isRemovedOnCompletion = false
            orbit.fillMode = kCAFillModeForwards
            imgViewDot.layer.add(orbit,forKey:"Move")
            imgViewDot.isHidden = false
        }
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
    
    
    @objc func click() {
        
        count += 0.25
        progress(count)
    }
    
   
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
}
