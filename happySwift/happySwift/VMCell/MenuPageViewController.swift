//
//  MenuPageViewController.swift
//  happySwift
//
//  Created by dfsx1 on 2019/3/21.
//  Copyright © 2019 slardar. All rights reserved.
//

import UIKit
//    @objc optional func willMoveToPage(_ controller: UIViewController, index: Int)

@objc public protocol MenuPageViewControllerDelegate: class {
    @objc optional func willMove(to controller: UIViewController, index: Int)
    @objc optional func didMove(to controller: UIViewController, index: Int)
}

open class MenuPageViewController: UIViewController {

    //TODO: 代理
    weak open var delegate: MenuPageViewControllerDelegate?
    
    //TODO: 标题栏
    // 标题间距
    public var menuItemDistance: CGFloat = 5 {
        didSet {
            self.flowLayout.minimumInteritemSpacing = menuItemDistance
        }
    }
    // 标题栏目缩进
    public var menuItemMargin: CGFloat = 5 {
        didSet {
            self.flowLayout.sectionInset = UIEdgeInsets(top: 0, left: menuItemMargin, bottom: 0, right: menuItemMargin)
        }
    }
    // 标题栏高度
    public var menuItemHeight: CGFloat = 32
    // 标题字号
    public var menuItemFont = UIFont.systemFont(ofSize: 17)
    // 标题正常颜色
    public var menuItemNormalTextColor = UIColor.black
    // 标题选中颜色
    public var menuItemSelectedTextColor = UIColor.red
    // 标题选中角标
    fileprivate var menuItemSelectedIndex: Int = 0
    //TODO: 标题栏下标指示器
    fileprivate lazy var menuItemIndicatorScrollView: UIScrollView = {
        let menuItemIndicatorScrollView = UIScrollView()
        menuItemIndicatorScrollView.delegate = self
        //menuItemIndicatorScrollView.backgroundColor = .green
        menuItemIndicatorScrollView.showsVerticalScrollIndicator = false
        menuItemIndicatorScrollView.showsHorizontalScrollIndicator = false
        self.menuItemIndicator.backgroundColor = self.menuItemIndicatorColor
        menuItemIndicatorScrollView.addSubview(self.menuItemIndicator)
        return menuItemIndicatorScrollView
    }()
    fileprivate lazy var menuItemIndicator: UIView = {
        let menuItemIndicator = UIView()
        menuItemIndicator.clipsToBounds = true
        return menuItemIndicator
    }()
    // 指示器尺寸（等于zero时默认与标题长度相等, 设置其它值时 menuItemIndicatorSize.height <= menuItemIndicatorHeight）
    public var menuItemIndicatorSize: CGSize = .zero
    // 指示器高度
    public var menuItemIndicatorHeight: CGFloat = 2
    // 指示器颜色
    public var menuItemIndicatorColor = UIColor.red {
        didSet {
            self.menuItemIndicator.backgroundColor = menuItemIndicatorColor
        }
    }
    // 是否显示指示器
    public var menuItemIndicatorHidden: Bool = false {
        didSet {
            self.menuItemIndicator.isHidden = menuItemIndicatorHidden
        }
    }
    // 指示器圆角
    public var menuItemIndicatorCornerRadius: CGFloat = 0 {
        didSet {
            self.menuItemIndicator.layer.cornerRadius = menuItemIndicatorCornerRadius
        }
    }

    //TODO: 标题栏分割线
    fileprivate let menuItemSeparator = UIView()
    // 标题栏分割线高度
    public var menuItemSeparatorHeight: CGFloat = 0.5
    // 标题栏分割线颜色
    public var menuItemSeparatorColor = UIColor.lightGray {
        didSet {
            self.menuItemSeparator.backgroundColor = menuItemSeparatorColor
        }
    }
    // 是否显示标题栏分割线
    public var menuItemSeparatorHidden: Bool = false {
        didSet {
            self.menuItemSeparator.isHidden = menuItemSeparatorHidden
        }
    }

    //TODO: UICollectionView
    fileprivate let cellID = "MenuPageCellID"
    public lazy var flowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        return flowLayout
    }()
    public lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.flowLayout)
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(MenuPageCell.classForCoder(), forCellWithReuseIdentifier: self.cellID)
        return collectionView
    }()
    //TODO: UIScrollView
    public lazy var contentScrollView: UIScrollView = {
        let contentScrollView = UIScrollView()
        contentScrollView.isPagingEnabled = true
        contentScrollView.delegate = self
        return contentScrollView
    }()
    // 控制器数据源
    public var viewControllers: [UIViewController] = []
    // 标题栏上的icon
    public var viewItems: [UIView] = []
    
    //MARK:-
    override open func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.setupSubviews()
        
        
        
    }
    
    override open func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.collectionView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: menuItemHeight)
        self.menuItemIndicatorScrollView.frame = CGRect(x: 0, y: self.collectionView.frame.height - menuItemIndicatorHeight, width: self.collectionView.frame.width, height: menuItemIndicatorHeight)
        self.menuItemIndicatorScrollView.contentSize = CGSize(width: CGFloat(viewControllers.count) * self.contentScrollView.frame.width, height: menuItemIndicatorHeight)

        self.menuItemSeparator.frame = CGRect(x: 0, y: self.collectionView.frame.maxY, width: self.view.frame.width, height: menuItemSeparatorHeight)
        
        
        self.contentScrollView.frame = CGRect(x: 0, y: menuItemHeight + menuItemSeparatorHeight, width: self.view.frame.width, height: self.view.frame.height - menuItemHeight)
        self.contentScrollView.contentSize = CGSize(width: CGFloat(viewControllers.count) * self.contentScrollView.frame.width, height: self.contentScrollView.frame.height)
        
        for index in 0..<viewControllers.count {
            let controller = viewControllers[index]
            controller.view.frame = CGRect(x: CGFloat(index) * self.view.frame.width, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        }
        
        for index in 0..<viewItems.count {
            let viewItem = viewItems[index]
            viewItem.frame = CGRect(x: (self.collectionView.frame.width - CGFloat(index + 1) * menuItemHeight), y: 0, width: menuItemHeight, height: menuItemHeight - menuItemSeparatorHeight)
            self.view.addSubview(viewItem)
        }
    }
    
    fileprivate func setupSubviews() {
        
        
        self.view.addSubview(self.collectionView)
        self.collectionView.reloadData()
        self.view.addSubview(self.menuItemIndicatorScrollView)
        
        self.view.addSubview(self.menuItemSeparator)
        self.menuItemSeparator.backgroundColor = menuItemSeparatorColor
        self.menuItemSeparator.isHidden = viewControllers.count == 0 ? true : menuItemSeparatorHidden
        
        self.view.addSubview(self.contentScrollView)
        for index in 0..<viewControllers.count {
            let controller = viewControllers[index]
            addChild(controller)
            contentScrollView.addSubview(controller.view)
        }
        
        if #available(iOS 11.0, *) {
            self.collectionView.contentInsetAdjustmentBehavior = .never
            self.menuItemIndicatorScrollView.contentInsetAdjustmentBehavior = .never
            self.contentScrollView.contentInsetAdjustmentBehavior = .never
        } else {
            // Fallback on earlier versions
            self.automaticallyAdjustsScrollViewInsets = false
        }
    }
    
    //MARK:-
    public func reload(for controllers: [UIViewController]) {
        
        viewControllers = controllers
        //
        contentScrollView.subviews.forEach { (subview) in
            subview.removeFromSuperview()
        }
        children.forEach { (controller) in
            controller.willMove(toParent: nil)
            controller.view.removeFromSuperview()
            controller.removeFromParent()
        }
        
        self.contentScrollView.contentSize = CGSize(width: CGFloat(viewControllers.count) * self.contentScrollView.frame.width, height: self.contentScrollView.frame.height)

        for index in 0..<viewControllers.count {
            let controller = viewControllers[index]
            addChild(controller)
            contentScrollView.addSubview(controller.view)
            controller.view.frame = CGRect(x: CGFloat(index) * self.view.frame.width, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        }
        self.collectionView.reloadData()
        self.menuItemSeparator.isHidden = viewControllers.count == 0 ? true : menuItemSeparatorHidden

    }

    public func click(at index: Int) {
        if index < viewControllers.count {
            self.collectionView(collectionView, didSelectItemAt: IndexPath(item: index, section: 0))
        }
    }
   
}

extension MenuPageViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewControllers.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
        if let cell = collectionViewCell as? MenuPageCell {
            if indexPath.row < viewControllers.count {
                cell.labelTitle.text = viewControllers[indexPath.row].title
                
                if menuItemSelectedIndex == indexPath.row {
                    cell.labelTitle.textColor = menuItemSelectedTextColor
                } else {
                    cell.labelTitle.textColor = menuItemNormalTextColor
                }
                
            }
            return cell
        }
        return collectionViewCell
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row < viewControllers.count {
            if let title = viewControllers[indexPath.row].title {
                return title.exSize(in: CGSize(width: CGFloat.greatestFiniteMagnitude, height: menuItemHeight), font: menuItemFont)
            }
        }
        return CGSize(width: 0, height: 0)
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let cell = self.collectionView.cellForItem(at: indexPath) {
            
            self.delegate?.willMove?(to: viewControllers[indexPath.row], index: indexPath.row)
            
            menuItemSelectedIndex = indexPath.row
            collectionView.reloadData()
            
            if collectionView.contentSize.width > collectionView.frame.width {
                //FIXME: 点击居中
                let cellMinX = cell.frame.minX
                let cellMidX = cell.frame.midX
                let halfWidth = collectionView.frame.width / 2
                let halfMaxWdith = collectionView.contentSize.width - halfWidth
                if cellMinX > halfWidth && cellMinX < halfMaxWdith {
                    self.collectionView.setContentOffset(CGPoint(x: cellMidX - halfWidth, y: 0), animated: true)
                    self.menuItemIndicatorScrollView.setContentOffset(CGPoint(x: cellMidX - halfWidth, y: 0), animated: true)
                } else if cellMinX < halfMaxWdith {
                    self.collectionView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
                    self.menuItemIndicatorScrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
                } else if cellMinX > halfMaxWdith {
                    self.collectionView.setContentOffset(CGPoint(x: collectionView.contentSize.width - collectionView.frame.width, y: 0), animated: true)
                    self.menuItemIndicatorScrollView.setContentOffset(CGPoint(x: collectionView.contentSize.width - collectionView.frame.width, y: 0), animated: true)
                }
            }
            
            //FIXME: 移动指示器
            if menuItemIndicatorSize == .zero {
                menuItemIndicatorSize = CGSize(width: cell.frame.width, height: menuItemIndicatorHeight)
            }
            UIView.animate(withDuration: 0.5) {
                self.menuItemIndicator.frame = CGRect(origin: .zero, size: self.menuItemIndicatorSize)
                self.menuItemIndicator.center = CGPoint(x: cell.frame.midX, y: self.menuItemIndicatorSize.height / 2)
            }
            
            //FIXME: 移动内容页面
            contentScrollView.setContentOffset(CGPoint(x: collectionView.frame.width * CGFloat(menuItemSelectedIndex), y: 0), animated: false)
            
            self.delegate?.didMove?(to: viewControllers[indexPath.row], index: indexPath.row)

        }
        
        
    }
    
}

extension MenuPageViewController: UIScrollViewDelegate {
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView.isEqual(collectionView) {
            self.menuItemIndicatorScrollView.contentOffset = scrollView.contentOffset
        }
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        if scrollView.isEqual(contentScrollView) {
            
            let offsetX = scrollView.contentOffset.x
            if offsetX == 0 {
                menuItemSelectedIndex = 0
            } else {
                menuItemSelectedIndex = Int(offsetX / contentScrollView.frame.width)
            }
            self.collectionView(collectionView, didSelectItemAt: IndexPath(item: menuItemSelectedIndex, section: 0))

        }
        
    }
}


open class MenuPageCell: UICollectionViewCell {
    
    public var labelTitle = UILabel()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(self.labelTitle)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        self.labelTitle.frame = self.bounds
    }
}


