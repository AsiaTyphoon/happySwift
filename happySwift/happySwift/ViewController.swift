//
//  ViewController.swift
//  happySwift
//
//  Created by dfsx1 on 2018/7/2.
//  Copyright © 2018年 slardar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let cellID = "cell_id"

    lazy var collectionView: UICollectionView = {
        let frame = self.view.frame
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: frame.size.width-20, height: 50)
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
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! HSCollectionViewCell
       
        cell.labelTitle.text = "wowo"
        
        return cell
    }
    
    
    
}
