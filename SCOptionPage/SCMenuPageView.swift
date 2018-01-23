//
//  SCMenuPageView.swift
//  SCOptionPageDemo
//
//  Created by kaito on 2018/1/23.
//  Copyright © 2018年 kaito. All rights reserved.
//

import UIKit

protocol SCMenuPageViewDataSource : class {
    func numberOfSections(_ menuPageView : SCMenuPageView) -> Int
    func pageCollectionView(_ menuPageView: SCMenuPageView, numberOfItemsInSection section: Int) -> Int
    func pageCollectionView(_ menuPageView : SCMenuPageView,_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
}

class SCMenuPageView: UIView {

    weak var dataSource : SCMenuPageViewDataSource?
    
    fileprivate var titles : [String] = []
    fileprivate var isTitleInTop : Bool
    fileprivate var style : SCOptionPageStyle
    fileprivate var titleView : SCTitleView!
    fileprivate var layout : SCMenuPageCollectionViewFlowLayout
    fileprivate var collectionView : UICollectionView!
    fileprivate var pageControl : UIPageControl!
    fileprivate var sourceIndexPath : IndexPath = IndexPath(item: 0, section: 0)
    
    init(frame: CGRect, titles : [String], style : SCOptionPageStyle, isTitleInTop : Bool, layout : SCMenuPageCollectionViewFlowLayout) {
        self.titles = titles
        self.style = style
        self.isTitleInTop = isTitleInTop
        self.layout = layout

        super.init(frame: frame)

        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK:- 设置UI界面
extension SCMenuPageView {
    fileprivate func setupUI() {
        // 1.创建titleView
        let titleY = isTitleInTop ? 0 : bounds.height - style.titleViewHeight
        let titleFrame = CGRect(x: 0, y: titleY, width: bounds.width, height: style.titleViewHeight)
        titleView = SCTitleView(frame: titleFrame, titles: titles, style: style)
        titleView.backgroundColor = style.titleViewColor
        titleView.delegate = self
        addSubview(titleView)
       
        
        // 2.创建UIPageControl
        let pageControlY = isTitleInTop ? (bounds.height - style.pageControlHeight) : (bounds.height - style.pageControlHeight - style.titleViewHeight)
        let pageControlFrame = CGRect(x: 0, y: pageControlY, width: bounds.width, height: style.pageControlHeight)
        pageControl = UIPageControl(frame: pageControlFrame)
        pageControl.numberOfPages = style.pageControlNumber
        pageControl.isEnabled = false
        pageControl.tintColor = style.pageControlTintColor
        pageControl.currentPageIndicatorTintColor = style.pageControlCurrenColor
        pageControl.backgroundColor = style.pageControlColor
        addSubview(pageControl)
        
        // 3.创建UICollectionView
        let collectionViewY = isTitleInTop ? style.titleViewHeight : 0
        let collectionViewFrame = CGRect(x: 0, y: collectionViewY, width: bounds.width, height: bounds.height - style.titleViewHeight - style.pageControlHeight)
        collectionView = UICollectionView(frame: collectionViewFrame, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        addSubview(collectionView)
        collectionView.backgroundColor = UIColor.randomColor()
    }
}


// MARK:- 对外暴露的方法
extension SCMenuPageView {
    func register(cell : AnyClass?, identifier : String) {
        collectionView.register(cell, forCellWithReuseIdentifier: identifier)
    }
    
    func register(nib : UINib, identifier : String) {
        collectionView.register(nib, forCellWithReuseIdentifier: identifier)
    }
}


// MARK:- UICollectionViewDataSource
extension SCMenuPageView : UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataSource?.numberOfSections(self) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let itemCount = dataSource?.pageCollectionView(self, numberOfItemsInSection: section) ?? 0
        
        if section == 0 {
            pageControl.numberOfPages = (itemCount - 1) / (layout.cols * layout.rows) + 1
        }
        
        return itemCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return dataSource!.pageCollectionView(self, collectionView, cellForItemAt: indexPath)
    }
}

// MARK:- UICollectionViewDelegate
extension SCMenuPageView : UICollectionViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollViewEndScroll()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            scrollViewEndScroll()
        }
    }
    
    fileprivate func scrollViewEndScroll() {
        // 1.取出在屏幕中显示的Cell
        let point = CGPoint(x: layout.sectionInset.left + 1 + collectionView.contentOffset.x, y: layout.sectionInset.top + 1)
        guard let indexPath = collectionView.indexPathForItem(at: point) else { return }
        
        // 2.判断分组是否有发生改变
        if sourceIndexPath.section != indexPath.section {
            // 3.1.修改pageControl的个数
            let itemCount = dataSource?.pageCollectionView(self, numberOfItemsInSection: indexPath.section) ?? 0
            pageControl.numberOfPages = (itemCount - 1) / (layout.cols * layout.rows) + 1
            
            // 3.2.设置titleView位置
            titleView.titleViewChange(inIndex: indexPath.section)
            
            // 3.3.记录最新indexPath
            sourceIndexPath = indexPath
        }
        
        // 3.根据indexPath设置pageControl
        pageControl.currentPage = indexPath.item / (layout.cols * layout.rows)
    }
}

// MARK:- HYTitleViewDelegate
extension SCMenuPageView : SCTitleViewDeleate {
    
    func titleView(titleView : SCTitleView, currentIndex : Int){
        
        let indexPath = IndexPath(item: 0, section: currentIndex)
        collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
        collectionView.contentOffset.x -= layout.sectionInset.left
        
        scrollViewEndScroll()
    }
}


