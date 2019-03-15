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

class MirrorViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "mirror"
        self.view.backgroundColor = .white
        

        let dic: NSDictionary = ["name" : "lin", "age" : 10]
        let data = NSKeyedArchiver.archivedData(withRootObject: dic)
        do {
            let user = try JSONDecoder().decode(User.self, from: data)  
            print(user)
        } catch {
            
        }
        
        
        
        
        ERChild().startGet { (response, error) in
            
        }
        
        print("isUpperIphoneX: \(isUpperIphoneX)")
        print("machineName: \(UIDevice.current.machineName())")

    }
    
}
