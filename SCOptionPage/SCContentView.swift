//
//  SCContentView.swift
//  SCOptionPage
//
//  Created by Kaito on 2018/1/18.
//  Copyright © 2018年 kaito. All rights reserved.
//

import UIKit

private let kCell = "kCell"

protocol SCContentViewDelegate : class {

    func contentView(contentView : SCContentView, inIndex : Int)
}

class SCContentView: UIView {

     weak var delegate : SCContentViewDelegate?
    
    fileprivate var childVcs : [UIViewController]
    fileprivate var parentVc : UIViewController
    fileprivate var superView : SCOpitonPageView
    
    fileprivate lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = self.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kCell)
        collectionView.isPagingEnabled = true
        collectionView.scrollsToTop = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = backgroundColor
        
        return collectionView
    }()
    
    init(frame : CGRect, childVcs : [UIViewController], parentVc : UIViewController, superView: SCOpitonPageView) {
        
        self.childVcs = childVcs
        self.parentVc = parentVc
        self.superView = superView
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("不能从xib中加载")
    }
    
}

//MARK: - UI界面
extension SCContentView {
    
    fileprivate func setupUI(){
    
        for vc in childVcs {
            parentVc.addChildViewController(vc)
        }
        
        addSubview(collectionView)
        
    }
}

// MARK:- UICollectionViewDataSource协议
extension SCContentView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCell, for: indexPath)
        
        for subview in cell.contentView.subviews {
            subview.removeFromSuperview()
        }
        
        let vc = childVcs[indexPath.item]
        vc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(vc.view)
        
        return cell
    }
}


// MARK:- UICollectionViewDelegate协议
extension SCContentView : UICollectionViewDelegate {
   
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        collectionViewEndScroll()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            collectionViewEndScroll()
        }
    }
    
    private func collectionViewEndScroll() {
        
        let endIndex = Int(collectionView.contentOffset.x / collectionView.bounds.width)
        
        superView.delegate?.optionPageScroll(optionPage: superView, index: endIndex)
        delegate?.contentView(contentView: self, inIndex: endIndex)
    }
}

// MARK:- 遵守HYTitleViewDelegate协议
extension SCContentView : SCTitleViewDeleate {
    func titleView(titleView: SCTitleView, currentIndex: Int) {
        
        let indexPath = IndexPath(item: currentIndex, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
    }
    
    
  
}


