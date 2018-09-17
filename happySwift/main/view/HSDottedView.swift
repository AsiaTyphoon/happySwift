//
//  HSDottedView.swift
//  happySwift
//
//  Created by dfsx1 on 2018/9/17.
//  Copyright © 2018年 slardar. All rights reserved.
//

import UIKit

enum HSDottedType {
    case normal //只是虚线框
    case zoom   // 缩放
    case translation    // 平移
}

class HSDottedView: UIView {
    
    // 默认为平移
    var type: HSDottedType = .zoom
    
    
    // 虚线框
    lazy var dottedLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        // stroke color
        layer.strokeColor = UIColor.red.cgColor
        // fill color
        layer.fillColor = UIColor.clear.cgColor
        // line width
        layer.lineWidth = 1.0
        // line dashPattern
        layer.lineDashPattern = [4.0, 2.0]
        return layer
    }()
    // 虚线框大小
    var dottedFrame: CGRect = .zero
    var dottedPath: UIBezierPath {
        get {
            return UIBezierPath(rect: dottedFrame)
        }
    }
    // 虚线框的变化区域
    var workFrame = CGRect.zero
    // 虚线框变化的最小size
    var minSize = CGSize(width: 50, height: 50)
    
    /*
     区分拖动开始的点击区域，以此来确定改变frame的具体值 此处设计为四宫格
     0  1
     2  3
     */
    var panPoint = 0
    // 拖动手势
    lazy var panGesture: UIPanGestureRecognizer = {
        return UIPanGestureRecognizer(target: self, action: #selector(pan(of:)))
    }()
    
    // 虚线框区域颜色
    var dottedColor = UIColor.clear
    // 遮罩颜色
    var coverColor = UIColor.gray.withAlphaComponent(0.3)
    
    
    //MARK:-
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addGestureRecognizer(panGesture)
        layer.addSublayer(dottedLayer)

        // frame
        dottedFrame = CGRect(x: 10, y: 10, width: min(100, frame.width), height: min(60, frame.height))
        workFrame = bounds
        backgroundColor = .clear
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    deinit {
        print("-----deinit-----\(self.classForCoder)")
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        dottedLayer.path = dottedPath.cgPath
        
        // 整体颜色
        coverColor.setFill()
        UIRectFill(rect);
        
        // 相交区域
        let holeRect = rect.intersection(dottedFrame)
        // 相交区域颜色
        dottedColor.setFill()
        UIRectFill(holeRect);
    }
    
    
    @objc func pan(of: UIPanGestureRecognizer?) {
        
        
        guard let pang: UIPanGestureRecognizer = of else {
            return
        }
        
        let position = pang.velocity(in: self)
        let offx = position.x / 100.0
        let offy = position.y / 100.0
        
        if pang.state == .began {
            
        }
        else if pang.state == .changed {
            
            
            if type == .translation {
                // 平移
                dottedFrame.origin.x += offx
                if dottedFrame.origin.x < workFrame.origin.x {
                    dottedFrame.origin.x = workFrame.origin.x
                }
                if dottedFrame.maxX > workFrame.maxX {
                    dottedFrame.origin.x = workFrame.maxX - dottedFrame.width
                }
                dottedFrame.origin.y += offy
                if dottedFrame.origin.y < workFrame.origin.y {
                    dottedFrame.origin.y = workFrame.origin.y
                }
                if dottedFrame.maxY > workFrame.maxY {
                    dottedFrame.origin.y = workFrame.maxY - dottedFrame.height
                }
               
                
            } else if type == .zoom {
                // 缩放

                if panPoint == 0 {
                    
                    dottedFrame.origin.x += offx
                    dottedFrame.origin.y += offy
                    dottedFrame.size.width -= offx
                    dottedFrame.size.height -= offy
                }
                else if panPoint == 1 {
                    
                    dottedFrame.origin.y += offy
                    dottedFrame.size.width += offx
                    dottedFrame.size.height -= offy
                }
                else if panPoint == 2 {
                    
                    dottedFrame.origin.x += offx
                    dottedFrame.size.width -= offx
                    dottedFrame.size.height += offy
                }
                else if panPoint == 3 {
                    
                    dottedFrame.size.width += offx
                    dottedFrame.size.height += offy
                }
                
                // workFrame为指定的变化区域
                if dottedFrame.origin.x < workFrame.origin.x {
                    dottedFrame.origin.x = workFrame.origin.x
                }
                if dottedFrame.origin.x > workFrame.maxX - minSize.width {
                    dottedFrame.origin.x = workFrame.maxX - minSize.width
                }
                if dottedFrame.origin.y < workFrame.origin.y {
                    dottedFrame.origin.y = workFrame.origin.y
                }
                if dottedFrame.origin.y > workFrame.maxY - minSize.height {
                    dottedFrame.origin.y = workFrame.maxY - minSize.height
                }
                if dottedFrame.size.width < minSize.width {
                    dottedFrame.size.width = minSize.width
                }
                if dottedFrame.maxX > workFrame.maxX {
                    dottedFrame.size.width = workFrame.maxX - dottedFrame.minX
                }
                if dottedFrame.size.height < minSize.height {
                    dottedFrame.size.height = minSize.height
                }
                if dottedFrame.maxY > workFrame.maxY {
                    dottedFrame.size.height = workFrame.maxY - dottedFrame.minY
                }

            }
            
            setNeedsLayout()
            setNeedsDisplay()

        }
        else if pang.state == .ended {
            
        }
        
    }
    
    
    //MARK:-
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {

        let fw = self.frame.size.width
        let fh = self.frame.size.height

        if point.x <= fw / 2 && point.y <= fh / 2 {
            panPoint = 0
        }
        else if point.x >= fw / 2 && point.y <= fh / 2 {
            panPoint = 1
        }
        else if point.x <= fw / 2 && point.y >= fh / 2 {
            panPoint = 2
        }
        else if point.x >= fw / 2 && point.y >= fh / 2 {
            panPoint = 3
        }

        return super.hitTest(point, with: event)
    }

    
}
