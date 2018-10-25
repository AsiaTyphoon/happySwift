//
//  ViewController.swift
//  happySwift
//
//  Created by dfsx1 on 2018/7/2.
//  Copyright © 2018年 slardar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    struct ID {
        static let cellID = "xxxID"
        static let bundleName = "resources"
        static let bundleType = "bundle"
    }
    
    var fileNames: [String] = []
    var dataArrs: [[String : Any]] = []
    
    lazy var collectionView: UICollectionView = {
        let frame = self.view.frame
        let layout = HSCollectionViewFlowLayout(.left)
        
        layout.scrollDirection = .vertical
        layout.estimatedItemSize = CGSize(width: frame.size.width - 20, height: 50)
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

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return fileNames.count
        return dataArrs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ID.cellID, for: indexPath) as? HSCollectionViewCell {
            let dic = dataArrs[indexPath.row]
            if let title = dic[HS.title] as? String {
                cell.labelTitle.text = title
            }
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let dic = dataArrs[indexPath.row]
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
