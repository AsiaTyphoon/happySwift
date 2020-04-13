//
//  ViewController.swift
//  happySwift
//
//  Created by dfsx1 on 2018/7/2.
//  Copyright © 2018年 slardar. All rights reserved.
//

import UIKit

struct Person {
    struct Sex {
        static let boy = "boy"
    }
}


//MARK:-
class ViewController: UIViewController {

    struct ID {
        static let cellID = "xxxID"
        static let bundleName = "resources"
        static let bundleType = "bundle"
    }
    
    var fileNames: [String] = []
    
    var dataArrs: [Any] = []
    
    lazy var collectionView: UICollectionView = {
        let frame = self.view.frame
        //let layout = HSCollectionViewFlowLayout(.left)
        let layout = UICollectionViewFlowLayout()

        layout.scrollDirection = .vertical
        //layout.estimatedItemSize = CGSize(width: frame.size.width - 20, height: 50)
        
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        let tmpCollectionView = UICollectionView.init(frame: frame, collectionViewLayout: layout)
        tmpCollectionView.frame = self.view.frame
        tmpCollectionView.collectionViewLayout = layout
        tmpCollectionView.delegate = self
        tmpCollectionView.dataSource = self
        tmpCollectionView.register(HSCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: ID.cellID)
        tmpCollectionView.backgroundColor = UIColor.white
        
        return tmpCollectionView
    }()

    //MARK:-
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.addSubview(collectionView)
        loadData()
        
        for object in self.dataArrs {
            if let vmobject = object as? VMObject {
                self.collectionView.register(vmobject.item, forCellWithReuseIdentifier: vmobject.reuseID)
            }
        }
        
        collectionView.reloadData()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func loadData() {
        
        self.dataArrs.append(VMObjectMirror())
        self.dataArrs.append(VMObjectFirst())
        self.dataArrs.append(VMObjectSecond())
        
        dataArrs.append([HS.type : HSType.ui, HS.title : "UI测试"])
        
        //获取bundle路径
        guard let bundlePath = Bundle.main.path(forResource: ID.bundleName, ofType: ID.bundleType) else {
            return
        }
        //遍历bundle内的文件
        do {
            let contents = try FileManager.default.contentsOfDirectory(atPath: bundlePath)
            for fileName in contents {
//                fileNames.append(fileName)
                let filePath = bundlePath + "/" + fileName
                dataArrs.append([HS.type : HSType.file, HS.path : filePath, HS.title : fileName])
            }
        } catch {
            print("read_bundle_error:\(error)")
        }
        
        
    }
}

class ERChild: ERNetwork {
    
    override init() {
        super.init()
//        baseURL = "http://192.168.6.30:8001"
//        path = "/public/settings"
        
        baseURL = "http://dsapi.wsrtv.com.cn"
        path = "/cms/public/v2/columns"
    
        
        print(Person.Sex.boy)
    }
}

class mmmodel: NSObject {
    
    var phone_verification = false
    var site_logo_url: String?
    var site_register: String?
    var api_version: String?
    var min_bc_api_version: String?
    var ios_min_version: String?
    var android_min_version: String?
    var ios_published: String?
    var youzan_client_id: String?
    var name: String?
    var api: Any?
    var mweb: Any?
    var external_live: Any?

}


//MARK:-
extension ViewController: UICollectionViewDataSource {
    //TODO: UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArrs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let object = self.dataArrs[indexPath.row] as? VMObject {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: object.reuseID, for: indexPath)
            if let sourceCell = cell as? VMCellDataSource {
                sourceCell.setDataSource(self, object)
            }
            return cell
        }
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ID.cellID, for: indexPath) as? HSCollectionViewCell {
            if let dic = dataArrs[indexPath.row] as? [String : Any] {
                if let title = dic[HS.title] as? String {
                    cell.labelTitle.text = title
                }
            }
            
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    
}

extension ViewController: UICollectionViewDelegate {
    //TODO: UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let cell = collectionView.cellForItem(at: indexPath) as? VMCellDataSource {
            cell.didSelected?(self, nil)
        }
        
        if let dic = dataArrs[indexPath.row] as? [String : Any] {
            if let type = dic[HS.type] as? HSType {
                if type == .ui {
                    let uiVC = HSUITestViewController()
                    if let title = dic[HS.title] as? String {
                        uiVC.title = title
                    }
                    self.navigationController?.pushViewController(uiVC, animated: true)
                } else if type == .file {
                    if let path = dic[HS.path] as? String, let title = dic[HS.title] as? String {
                        let showVC: HSShowViewController! = HSShowViewController()
                        showVC.fileUrl = URL(fileURLWithPath: path)
                        showVC.title = title
                        self.navigationController?.pushViewController(showVC, animated: true)
                    }
                }
            }
        }
        
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    //TODO: UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let object = self.dataArrs[indexPath.row] as? VMObject {
            return object.itemSize
        }
        return CGSize(width: 320, height: 60)
    }
}


