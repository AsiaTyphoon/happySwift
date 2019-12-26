//
//  HSUITestViewController.swift
//  happySwift
//
//  Created by dfsx1 on 2018/9/14.
//  Copyright © 2018年 slardar. All rights reserved.
//

import UIKit

class HSUITestViewController: UIViewController {

    var dataArr: [[String : Any]] = []
    
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = CGSize(width: 100, height: 50)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        let frame = CGRect(x: 0, y: kSCREENH - 50, width: kSCREENW, height: 100)
        let tmpCollectionView = UICollectionView.init(frame: frame, collectionViewLayout: layout)
        tmpCollectionView.collectionViewLayout = layout
        tmpCollectionView.delegate = self
        tmpCollectionView.dataSource = self
        tmpCollectionView.register(HSCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: HS.cellID)
        tmpCollectionView.backgroundColor = UIColor.white
        
        return tmpCollectionView
    }()
    
    //MARK:-  viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        
        dataArr.append([HS.title : "虚线框", HS.selector : #selector(testDot)])
        dataArr.append([HS.title : "进度条", HS.selector : #selector(testProgress)])
        
        view.addSubview(collectionView)
        collectionView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    deinit {
        print("----- deinit ----- \(self.classForCoder)")
    }

    @objc func testDot() {
        
        for subview in view.subviews {
            if subview.isKind(of: HSDottedView.self) {
                subview.removeFromSuperview()
            }
        }
        
        let dview = HSDottedView(frame: CGRect(x: 0, y: 64, width: view.frame.width, height: view.frame.height - 100))
        view.addSubview(dview)
    }
    
    @objc func testProgress() {
        
        let progress = HSProgressView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        progress.center = view.center
        progress.backgroundColor = .white
        view.addSubview(progress)
        
        
        var count: CGFloat = 0
        exDispatchTimer(timeInterval: 0.05) { (timer) in
            progress.progress(count)
            count += 0.01
            if count >= 10 {
                timer?.cancel()
            }
        }
    }
}

extension HSUITestViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HS.cellID, for: indexPath) as? HSCollectionViewCell {
            let dic = dataArr[indexPath.row]
            if let title = dic[HS.title] as? String {
                cell.labelTitle.text = title
            }
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let dic = dataArr[indexPath.row]
        if let selector = dic[HS.selector] as? Selector {
            perform(selector)
        }
    }
}
