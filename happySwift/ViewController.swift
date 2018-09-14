//
//  ViewController.swift
//  happySwift
//
//  Created by dfsx1 on 2018/7/2.
//  Copyright © 2018年 slardar. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIWebViewDelegate{

    let cellID = "cell_id"
    var bundlePath: String?
    
    lazy var fileNames: NSMutableArray = {
        return NSMutableArray.init()
    }()
    
    lazy var collectionView: UICollectionView = {
        let frame = self.view.frame
        let layout = DSCollectionViewFlowLayout(.left)
        
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
        tmpCollectionView.register(HSCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: cellID)
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func loadData() {
        //获取bundle路径
        bundlePath = Bundle.main.path(forResource: "resources", ofType: "bundle")
        guard let _ = bundlePath else { return }
        //遍历bundle内的文件
        let contents = try? FileManager.default.contentsOfDirectory(atPath: bundlePath!)
        guard let _ = contents else { return }
        
        for (_, value) in contents!.enumerated() {
            fileNames.add(value)
        }
        
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fileNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! HSCollectionViewCell
        cell.labelTitle.text = fileNames[indexPath.row] as? String
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //获取bundle对象
        guard let _ = bundlePath else { return }
        let bundleResources = Bundle(path: bundlePath!)
        guard let _ = bundleResources else { return }
        let str = fileNames[indexPath.row] as? String
        guard let _ = str else { return }
        let fileUrl = bundleResources!.url(forAuxiliaryExecutable: str!)
        print("filePath: \(String(describing: fileUrl))")
        
        let showVC: HSShowViewController! = HSShowViewController()
        showVC.fileUrl = fileUrl
        showVC.title = str
        self.navigationController?.pushViewController(showVC, animated: true)
    }
    
}
