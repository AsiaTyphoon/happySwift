//
//  VMCellFirst.swift
//  happySwift
//
//  Created by dfsx1 on 2019/2/26.
//  Copyright © 2019 slardar. All rights reserved.
//

import UIKit
import SDWebImage
import AVKit

open class VMCellFirst: UICollectionViewCell {
    
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

//MARK:-
extension VMCellFirst: VMCellDataSource {
    //TODO: VMCellDataSource
    public func setDataSource(_ sender: Any?, _ dataSource: Any?) {
        if let object = dataSource as? VMObjectFirst {
            self.labelTitle.text = object.title
        }
    }
    
    public func didSelected(_ sender: Any?, _ dataSource: Any?) {
        print("didselect first cell")
        
        if let currentVC = sender as? UIViewController {
            let targetVC = UILabelViewController()
            currentVC.navigationController?.pushViewController(targetVC, animated: true)
        }
    }
}


//MARK:-
open class VMObjectFirst: VMObject {
    
    override public init() {
        super.init()

        self.item = VMCellFirst.classForCoder()
        self.reuseID = "VMCellFirstID"
        self.title = "I am first cell"
        self.itemSize = CGSize(width: 320, height: 80)
    }
}


//MARK:-
class UILabelViewController: UIViewController, PaikeScrollViewDelegate {
    
    lazy var paikeView: PaikeScrollView = {
        let paikeView = PaikeScrollView(frame: CGRect(x: 10, y: 100, width: self.view.frame.width - 20, height: self.view.frame.height - 134))
        return paikeView
    }()

    var index: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        let address = "http://ksy.fffffive.com/mda-hinp1ik37b0rt1mj/mda-hinp1ik37b0rt1mj.mp4"
//        if let url = URL(string: address) {
//            let palyer = AVPlayerLayer(player: AVPlayer(playerItem: nil))
//            palyer.player?.replaceCurrentItem(with: AVPlayerItem(url: url))
//            palyer.frame = CGRect(x: 0, y: 100, width: 350, height: 300)
//            palyer.player?.play()
//            self.view.layer.addSublayer(palyer)
//        }
//
//        return


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
        
        
        paikeView.live = lives.first
        paikeView.index = 0
        paikeView.playerDelegate = self
        self.view.addSubview(paikeView)
        paikeView.updateForLives(livesArray: lives, index: 0)
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        paikeView.middlePlayer.player?.play()
    }
    
    func playerScrollView(paikeScrollView: PaikeScrollView, index: Int) {
        
    }
    
}

protocol PaikeScrollViewDelegate: class {
    func playerScrollView(paikeScrollView: PaikeScrollView, index: Int)
}

//MARK:-
class PaikeScrollView: UIScrollView, UIScrollViewDelegate {
    
    weak open var playerDelegate: PaikeScrollViewDelegate?
    
    var lives: [PaikeContent] = []
    var live: PaikeContent?
    
    var upperLive: PaikeContent?
    var middleLive: PaikeContent?
    var downLive: PaikeContent?
    
    var upperImageView = UIImageView()
    var middleImageView = UIImageView()
    var downImageView = UIImageView()

    
    lazy var upPerPlayer: AVPlayerLayer = {
        let upPerPlayer = AVPlayerLayer(player: AVPlayer(playerItem: nil))
        upPerPlayer.backgroundColor = UIColor.clear.cgColor
        upPerPlayer.videoGravity = .resizeAspectFill
        return upPerPlayer
    }()
    lazy var middlePlayer: AVPlayerLayer = {
        let middlePlayer = AVPlayerLayer(player: AVPlayer(playerItem: nil))
        middlePlayer.backgroundColor = UIColor.clear.cgColor
        middlePlayer.videoGravity = .resizeAspectFill
        return middlePlayer
    }()
    lazy var downPlayer: AVPlayerLayer = {
        let downPlayer = AVPlayerLayer(player: AVPlayer(playerItem: nil))
        downPlayer.backgroundColor = UIColor.clear.cgColor
        downPlayer.videoGravity = .resizeAspectFill
        return downPlayer
    }()
    
    var index: Int = 0
    var currentIndex: Int = 0
    var previousIndex: Int = 0
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentSize = CGSize(width: 0, height: frame.height * 3)
        self.contentOffset = CGPoint(x: 0, y: frame.height)
        self.isPagingEnabled = true
        self.isOpaque = true
        self.backgroundColor = .clear
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        if #available(iOS 11.0, *) {
            self.contentInsetAdjustmentBehavior = .never
        } else {
            // Fallback on earlier versions
        }
        self.delegate = self
        
        self.upperImageView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        self.middleImageView.frame = CGRect(x: 0, y: frame.height, width: frame.width, height: frame.height)
        self.downImageView.frame = CGRect(x: 0, y: frame.height * 2, width: frame.width, height: frame.height)
        self.addSubview(self.upperImageView)
        self.addSubview(self.middleImageView)
        self.addSubview(self.downImageView)
        
        
        if let address = live?.address, let url = URL(string: address) {
            upPerPlayer.player?.replaceCurrentItem(with: AVPlayerItem(url: url))
            middlePlayer.player?.replaceCurrentItem(with: AVPlayerItem(url: url))
            downPlayer.player?.replaceCurrentItem(with: AVPlayerItem(url: url))

        }
        upPerPlayer.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        self.layer.addSublayer(upPerPlayer)
        
        middlePlayer.frame = CGRect(x: 0, y: frame.height, width: frame.width, height: frame.height)
        self.layer.addSublayer(middlePlayer)
        
        downPlayer.frame = CGRect(x: 0, y: frame.height * 2, width: frame.width, height: frame.height)
        self.layer.addSublayer(downPlayer)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func updateForLives(livesArray: [PaikeContent], index: Int) {
        if let _ = livesArray.first {
            self.lives.removeAll()
            self.lives = livesArray
            self.currentIndex = index
            self.previousIndex = index
            
            upperLive = PaikeContent()
            middleLive = self.lives[self.currentIndex]
            downLive = PaikeContent()
            
            if currentIndex == 0 {
                upperLive = lives.last
            } else {
                upperLive = lives[currentIndex - 1]
            }
            
            if currentIndex == lives.count - 1 {
                downLive = lives.first
            } else {
                downLive = lives[currentIndex + 1]
            }
            
            
            self.prepareForImageView(imageView: upperImageView, live: upperLive!)
            self.prepareForImageView(imageView: middleImageView, live: middleLive!)
            self.prepareForImageView(imageView: downImageView, live: downLive!)

            self.prepareForVideo(playerLayer: upPerPlayer, live: upperLive!)
            self.prepareForVideo(playerLayer: middlePlayer, live: middleLive!)
            self.prepareForVideo(playerLayer: downPlayer, live: downLive!)
        }
    }
    
    
    func prepareForImageView(imageView: UIImageView, live: PaikeContent) {
        if let coverUrl = live.coverUrl {
            imageView.sd_setImage(with: URL(string: coverUrl), completed: nil)
        }
    }
    
    func prepareForVideo(playerLayer: AVPlayerLayer, live: PaikeContent) {
        if let address = live.address, let url = URL(string: address) {
            playerLayer.player?.replaceCurrentItem(with: AVPlayerItem(url: url))
        }
    }
    
    func switchPlayer(scrollView: UIScrollView) {
        let offset: CGFloat = scrollView.contentOffset.y
        
        if self.lives.count > 0 {
            if offset >= (2 * frame.height) {
                scrollView.contentOffset = CGPoint(x: 0, y: frame.height)
                currentIndex += 1
                self.upperImageView.image = self.middleImageView.image
                self.middleImageView.image = self.downImageView.image
                
                if upPerPlayer.frame.minY == 0 {
                    upPerPlayer.frame = CGRect(x: 0, y: frame.height * 2, width: frame.width, height: frame.height)
                } else {
                    upPerPlayer.frame = CGRect(x: 0, y: upPerPlayer.frame.minY - frame.height, width: frame.width, height: frame.height)
                }
                
                if middlePlayer.frame.minY == 0 {
                    middlePlayer.frame = CGRect(x: 0, y: frame.height * 2, width: frame.width, height: frame.height)
                } else {
                    middlePlayer.frame = CGRect(x: 0, y: middlePlayer.frame.minY - frame.height, width: frame.width, height: frame.height)
                }
                
                if currentIndex == (lives.count - 1) {
                    downLive = lives.first
                } else if currentIndex == lives.count {
                    downLive = lives.first
                    currentIndex = 0
                } else {
                    downLive = lives[currentIndex + 1]
                }
                self.prepareForImageView(imageView: self.downImageView, live: downLive!)
                
                
                
                if downPlayer.frame.minY == 0 {
                    downPlayer.frame = CGRect(x: 0, y: frame.height * 2, width: frame.width, height: frame.height)
                } else {
                    downPlayer.frame = CGRect(x: 0, y: downPlayer.frame.minY - frame.height, width: frame.width, height: frame.height)
                }
                
                if upPerPlayer.frame.minY == (frame.height * 2) {
                    self.prepareForVideo(playerLayer: upPerPlayer, live: downLive!)
                }
                if middlePlayer.frame.minY == (frame.height * 2) {
                    self.prepareForVideo(playerLayer: middlePlayer, live: downLive!)
                }
                if downPlayer.frame.minY == (frame.height * 2) {
                    self.prepareForVideo(playerLayer: downPlayer, live: downLive!)
                }
                
                
                if previousIndex == currentIndex {
                    return
                }
                
                self.playerDelegate?.playerScrollView(paikeScrollView: self, index: currentIndex)
                
            } else if offset <= 0 {
                scrollView.contentOffset = CGPoint(x: 0, y: frame.height)
                
                currentIndex -= 1
                self.downImageView.image = self.middleImageView.image
                
                
                if downPlayer.frame.minY == (2 * frame.height) {
                    downPlayer.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
                } else {
                    downPlayer.frame = CGRect(x: 0, y: 0, width: downPlayer.frame.minY + frame.width, height: frame.height)
                }
                
                
                self.middleImageView.image = self.upperImageView.image
                
                
                if middlePlayer.frame.minY == (2 * frame.height) {
                    middlePlayer.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
                } else {
                    middlePlayer.frame = CGRect(x: 0, y: 0, width: middlePlayer.frame.minY + frame.width, height: frame.height)
                }
                
                
                if currentIndex == 0 {
                    upperLive = lives.last
                } else if currentIndex == -1 {
                    upperLive = lives[lives.count - 1]
                    currentIndex = lives.count - 1
                } else {
                    upperLive = lives[currentIndex - 1]
                }
                self.prepareForImageView(imageView: self.upperImageView, live: upperLive!)
                
                
                if upPerPlayer.frame.minY == (2 * frame.height) {
                    upPerPlayer.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
                } else {
                    upPerPlayer.frame = CGRect(x: 0, y: 0, width: upPerPlayer.frame.minY + frame.width, height: frame.height)
                }
                
                if (upPerPlayer.frame.minY == 0 ) {
                    self.prepareForVideo(playerLayer: upPerPlayer, live: upperLive!)
                }
                if (middlePlayer.frame.minY == 0 ) {
                    self.prepareForVideo(playerLayer: middlePlayer, live: upperLive!)
                }
                if (downPlayer.frame.minY == 0 ) {
                    self.prepareForVideo(playerLayer: downPlayer, live: upperLive!)
                }
                
                
                if previousIndex == currentIndex {
                    return
                }
                
                 self.playerDelegate?.playerScrollView(paikeScrollView: self, index: currentIndex)
            }
        }
        
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        switchPlayer(scrollView: scrollView)
    }
}


//MARK:-
class PaikeContent: NSObject {
    var address: String?
    var coverUrl: String?
}
