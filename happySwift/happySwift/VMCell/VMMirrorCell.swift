//
//  VMMirrorCell.swift
//  happySwift
//
//  Created by dfsx1 on 2019/3/8.
//  Copyright © 2019 slardar. All rights reserved.
//

import UIKit

class VMMirrorCell: UICollectionViewCell {
    
    public var labelTitle = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(self.labelTitle)
        self.backgroundColor = .red
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        self.labelTitle.frame = self.bounds
    }
}

extension VMMirrorCell: VMCellDataSource {
    func setDataSource(_ sender: Any?, _ dataSource: Any?) {
        if let object = dataSource as? VMObjectMirror {
            self.labelTitle.text = object.title
        }
    }
    
    func didSelected(_ sender: Any?, _ dataSource: Any?) {
        
        if let currentVC = sender as? UIViewController {
            let targetVC = MirrorViewController()
            currentVC.navigationController?.pushViewController(targetVC, animated: true)
        }
        
        
    }
}

//MARK:-
open class VMObjectMirror: VMObject {
    
    override public init() {
        super.init()
        
        self.item = VMMirrorCell.classForCoder()
        self.reuseID = "VMMirrorCellID"
        self.title = "I am mirror cell"
        self.itemSize = CGSize(width: 320, height: 50)
    }
}


class Api: NSObject {
    
}

struct User: Codable {
    
    
    
    var name: String?
    var age: Int?
    
}

class DSSlider: UISlider {
    
        override func trackRect(forBounds bounds: CGRect) -> CGRect {
            let rect = super.trackRect(forBounds: bounds)
            return CGRect(x: rect.origin.x - 15, y: rect.origin.y, width: rect.size.width + 30, height: rect.size.height)
        }
    
//    override func thumbRect(forBounds bounds: CGRect, trackRect rect: CGRect, value: Float) -> CGRect {
//        let oriRect = super.thumbRect(forBounds: bounds, trackRect: rect, value: value)
//        //        return CGRect(x: oriRect.minX - 10, y: oriRect.minY, width: oriRect.width + 10, height: 0.1)
//    }
}

class MirrorViewController: UIViewController {
    
    let menuVC = MenuPageViewController()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "mirror"
        self.view.backgroundColor = .white
        
        
        let slider = DSSlider()
        slider.clipsToBounds = true
        slider.thumbTintColor = .clear
        slider.frame = CGRect(x: 20, y: 200, width: 300, height: 5)
        slider.backgroundColor = .red
        self.view.addSubview(slider)
        
        return
        

        let dic: NSDictionary = ["name" : "lin", "age" : 10]
        let data = NSKeyedArchiver.archivedData(withRootObject: dic)
        do {
            let user = try JSONDecoder().decode(User.self, from: data)  
            print(user)
        } catch {
            
        }
        
        
        
        let str = "dfsxldtv://portal/node?content_id=26678820&type=content"
//        let str = "dfsxldtv://i/vcard"
        //let str = "dfsxldtv://sns/column?column_id=dangyuanluntan"
        //let url = URL(string: str)
        guard let components = NSURLComponents.init(string: str), components.scheme == "dfsxldtv" else {
            return
        }
        let queryItems = components.queryItems?.filter{ $0.name == "content_id" }
        if let item = queryItems?.first {
            
        }
        
        
        
        ERChild().startGet { (response, error) in
            
        }
        
        print("isUpperIphoneX: \(isUpperIphoneX)")
        print("machineName: \(UIDevice.current.machineName())")

        for index in 0..<4 {
            let vc = UIViewController()
            vc.title = "\(index)"
            vc.view.backgroundColor = .red
            //menuVC.viewControllers.append(vc)
        }
        
        let view = UIView()
        view.backgroundColor = .purple
        menuVC.viewItems.append(view)
        
        let view1 = UIView()
        view1.backgroundColor = .black
        menuVC.viewItems.append(view1)
        
        menuVC.menuItemMargin = 30
        menuVC.menuItemDistance = 50
        menuVC.menuItemIndicatorSize = CGSize(width: 10, height: 3)
        menuVC.menuItemIndicatorHeight = 3
        menuVC.menuItemIndicatorCornerRadius = 1.5
        addChild(menuVC)
        menuVC.view.frame = CGRect(x: 10, y: 100, width: 350, height: 600)
        self.view.addSubview(menuVC.view)
        
        
        let button = UIButton()
        button.frame = CGRect(x: 0, y: self.view.frame.height - 84, width: 50, height: 50)
        button.backgroundColor = .green
        button.setTitle("RE", for: .normal)
        button.addTarget(self, action: #selector(clickReload(_:)), for: .touchUpInside)
        self.view.addSubview(button)
        
        
        let button1 = UIButton()
        button1.frame = CGRect(x: button.frame.maxX + 100, y: self.view.frame.height - 84, width: 50, height: 50)
        button1.backgroundColor = .green
        button1.setTitle("RE1", for: .normal)
        button1.addTarget(self, action: #selector(clickSelect(_:)), for: .touchUpInside)
        self.view.addSubview(button1)
        
    }
    
    @objc func clickReload(_ sender: Any) {
        var vcArr: [UIViewController] = []
        
        let first = UIViewController()
        first.title = "first"
        first.view.backgroundColor = .green
        vcArr.append(first)
        
        
        let second = UIViewController()
        second.title = "second"
        second.view.backgroundColor = .red
        vcArr.append(second)
        
        let third = UIViewController()
        third.title = "third"
        third.view.backgroundColor = .purple
        vcArr.append(third)

        let fourth = UIViewController()
        fourth.title = "fourth"
        fourth.view.backgroundColor = .green
        vcArr.append(fourth)


        let fifth = UIViewController()
        fifth.title = "fifth"
        fifth.view.backgroundColor = .red
        vcArr.append(fifth)

        let sixth = UIViewController()
        sixth.title = "sixth"
        sixth.view.backgroundColor = .purple
        vcArr.append(sixth)
        
        
        menuVC.reload(for: vcArr)
        
        exDispatchAfter(after: 0.5) {
            self.menuVC.click(at: 3)
        }
    }
    
    @objc func clickSelect(_ sender: Any) {
        menuVC.click(at: 3)
    }
    
}


