//
//  VMCellSecond.swift
//  happySwift
//
//  Created by dfsx1 on 2019/2/26.
//  Copyright © 2019 slardar. All rights reserved.
//

import UIKit
import AVKit

class VMCellSecond: UICollectionViewCell {
    
    public var labelTitle = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(self.labelTitle)
        self.backgroundColor = .green
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        self.labelTitle.frame = self.bounds
    }
}


//MARK:-
extension VMCellSecond: VMCellDataSource {
    //TODO: VMCellDataSource
    public func setDataSource(_ sender: Any?, _ dataSource: Any?) {
        if let object = dataSource as? VMObjectSecond {
            self.labelTitle.text = object.title
        }
    }
    
    public func didSelected(_ sender: Any?, _ dataSource: Any?) {
        if let currentVC = sender as? UIViewController {
            let targetVC = SecondViewController()
            currentVC.navigationController?.pushViewController(targetVC, animated: true)
        }
    }
}

//MARK:-
open class VMObjectSecond: VMObject {
    
    override public init() {
        super.init()
        
        self.item = VMCellSecond.classForCoder()
        self.reuseID = "VMCellSecondID"
        self.title = "I am second cell"
        self.itemSize = CGSize(width: 320, height: 50)
    }
}


class SecondViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {
    
    
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: self.view.frame.width - 20, height: self.view.frame.height - 134)
        layout.minimumLineSpacing = 0.1
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.isPagingEnabled = true
        collectionView.register(paikeCell.self, forCellWithReuseIdentifier: "cellID")
        return collectionView
    }()
    
    var dataArr: [PaikeContent] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "second"
        self.view.backgroundColor = .white
        
        
        let videos = ["http://ksy.fffffive.com/mda-hinp1ik37b0rt1mj/mda-hinp1ik37b0rt1mj.mp4",
                      "http://ksy.fffffive.com/mda-himtqzs2un1u8x2v/mda-himtqzs2un1u8x2v.mp4",
                      "http://ksy.fffffive.com/mda-hiw5zixc1ghpgrhn/mda-hiw5zixc1ghpgrhn.mp4",
                      "http://ksy.fffffive.com/mda-hiw61ic7i4qkcvmx/mda-hiw61ic7i4qkcvmx.mp4",
                      "http://ksy.fffffive.com/mda-hihvysind8etz7ga/mda-hihvysind8etz7ga.mp4",
                      "http://ksy.fffffive.com/mda-hiw60i3kczgum0av/mda-hiw60i3kczgum0av.mp4",
                      "http://ksy.fffffive.com/mda-hidnzn5r61qwhxp4/mda-hidnzn5r61qwhxp4.mp4",
                      "http://ksy.fffffive.com/mda-he1zy3rky0rwrf60/mda-he1zy3rky0rwrf60.mp4",
                      "http://ksy.fffffive.com/mda-hh6cxd0dqjqcszcj/mda-hh6cxd0dqjqcszcj.mp4",
                      "http://ksy.fffffive.com/mda-hifsrhtqjn8jxeha/mda-hifsrhtqjn8jxeha.mp4",
                      "http://ksy.fffffive.com/mda-hics799vjrg0w5az/mda-hics799vjrg0w5az.mp4",
                      "http://ksy.fffffive.com/mda-hfshah045smezhtf/mda-hfshah045smezhtf.mp4",
                      "http://ksy.fffffive.com/mda-hh4mbturm902j7wi/mda-hh4mbturm902j7wi.mp4",
                      "http://ksy.fffffive.com/mda-hiwxzficjivwmsch/mda-hiwxzficjivwmsch.mp4",
                      "http://ksy.fffffive.com/mda-hhug2p7hfbhnv40r/mda-hhug2p7hfbhnv40r.mp4",
                      "http://ksy.fffffive.com/mda-hieuuaei6cufye2c/mda-hieuuaei6cufye2c.mp4",
                      "http://ksy.fffffive.com/mda-hibhufepe5m1tfw1/mda-hibhufepe5m1tfw1.mp4",
                      "http://ksy.fffffive.com/mda-hhzeh4c05ivmtiv7/mda-hhzeh4c05ivmtiv7.mp4",
                      "http://ksy.fffffive.com/mda-hfrigfn2y9jvzm72/mda-hfrigfn2y9jvzm72.mp4",
                      "http://ksy.fffffive.com/mda-himek207gvvqg3wq/mda-himek207gvvqg3wq.mp4"]
        
        let imags = ["http://ksy.fffffive.com/mda-hinp1ik37b0rt1mj/mda-hinp1ik37b0rt1mj.jpg",
                     "http://ksy.fffffive.com/mda-himtqzs2un1u8x2v/mda-himtqzs2un1u8x2v.jpg",
                     "http://ksy.fffffive.com/mda-hiw5zixc1ghpgrhn/mda-hiw5zixc1ghpgrhn.jpg",
                     "http://ksy.fffffive.com/mda-hiw61ic7i4qkcvmx/mda-hiw61ic7i4qkcvmx.jpg",
                     "http://ksy.fffffive.com/mda-hihvysind8etz7ga/mda-hihvysind8etz7ga.jpg",
                     "http://ksy.fffffive.com/mda-hiw60i3kczgum0av/mda-hiw60i3kczgum0av.jpg",
                     "http://ksy.fffffive.com/mda-hidnzn5r61qwhxp4/mda-hidnzn5r61qwhxp4.jpg",
                     "http://ksy.fffffive.com/mda-he1zy3rky0rwrf60/mda-he1zy3rky0rwrf60.jpg",
                     "http://ksy.fffffive.com/mda-hh6cxd0dqjqcszcj/mda-hh6cxd0dqjqcszcj.jpg",
                     "http://ksy.fffffive.com/mda-hifsrhtqjn8jxeha/mda-hifsrhtqjn8jxeha.jpg",
                     "http://ksy.fffffive.com/mda-hics799vjrg0w5az/mda-hics799vjrg0w5az.jpg",
                     "http://ksy.fffffive.com/mda-hfshah045smezhtf/mda-hfshah045smezhtf.jpg",
                     "http://ksy.fffffive.com/mda-hh4mbturm902j7wi/mda-hh4mbturm902j7wi.jpg",
                     "http://ksy.fffffive.com/mda-hiwxzficjivwmsch/mda-hiwxzficjivwmsch.jpg",
                     "http://ksy.fffffive.com/mda-hhug2p7hfbhnv40r/mda-hhug2p7hfbhnv40r.jpg",
                     "http://ksy.fffffive.com/mda-hieuuaei6cufye2c/mda-hieuuaei6cufye2c.jpg",
                     "http://ksy.fffffive.com/mda-hibhufepe5m1tfw1/mda-hibhufepe5m1tfw1.jpg",
                     "http://ksy.fffffive.com/mda-hhzeh4c05ivmtiv7/mda-hhzeh4c05ivmtiv7.jpg",
                     "http://ksy.fffffive.com/mda-hfrigfn2y9jvzm72/mda-hfrigfn2y9jvzm72.jpg",
                     "http://ksy.fffffive.com/mda-himek207gvvqg3wq/mda-himek207gvvqg3wq.jpg"]
        
        var lives: [PaikeContent] = []
        for index in 0..<imags.count {
            let live = PaikeContent()
            live.coverUrl = imags[index]
            live.address = videos[index]
            lives.append(live)
        }
        dataArr = lives
        
        self.collectionView.frame = CGRect(x: 10, y: 100, width: self.view.frame.width - 20, height: self.view.frame.height - 134)
        self.view.addSubview(self.collectionView)
        self.collectionView.contentOffset = .zero
        //self.collectionView.reloadData()
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath) as? paikeCell {
            
            let paike = dataArr[indexPath.row]
            if let address = paike.address, let url = URL(string: address) {
                let item = AVPlayerItem(url: url)
                cell.setData(playerItem: item)
            }
            
            return cell
        }
        return UICollectionViewCell()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        print("\(indexPath.row)ddd")
        if let paikeCell = cell as? paikeCell {
            paikeCell.cellPlayer.seek(to: CMTime(value: 0, timescale: 1), completionHandler: { [weak self] (completion) in
                guard let strongSelf = self else { return }
                paikeCell.cellPlayer.pause()
            })
            
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = scrollView.contentOffset.y / scrollView.frame.height
        if let cell = self.collectionView.cellForItem(at: IndexPath(item: Int(index), section: 0)) as? paikeCell {
            cell.cellPlayer.seek(to: CMTime(value: 0, timescale: 1), completionHandler: { [weak self] (completion) in
                guard let strongSelf = self else { return }
                cell.cellPlayer.play()
            })
//            cell.cellPlayer.play()
        }
        
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
//        let offy = scrollView.contentOffset.y.truncatingRemainder(dividingBy: scrollView.frame.height)
//        if offy < scrollView.frame.height / 2 {
//            var offset = scrollView.contentOffset
//            offset.y -= offy
//            scrollView.setContentOffset(offset, animated: false)
//        } else {
//            var offset = scrollView.contentOffset
//            offset.y += scrollView.frame.height
//            scrollView.setContentOffset(offset, animated: false)
//        }
        
    }
}


class paikeCell: UICollectionViewCell {
    
    lazy var cellPlayer:AVPlayer = {
        let cellPlayer = AVPlayer(playerItem: nil)
        return cellPlayer
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .red
        
        let playerLayer = AVPlayerLayer(player: self.cellPlayer)
        playerLayer.frame = self.bounds
        self.layer.addSublayer(playerLayer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("----- deinit ----- \(self.classForCoder)")
    }
    
    //MARK:-
    func setData(playerItem: AVPlayerItem) {
        self.cellPlayer.replaceCurrentItem(with: nil)
        self.cellPlayer.replaceCurrentItem(with: playerItem)
    }
}
