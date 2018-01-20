//
//  SCOpitonPageView.swift
//  SCOptionPage
//
//  Created by Kaito on 2018/1/18.
//  Copyright © 2018年 kaito. All rights reserved.
//

import UIKit

protocol SCOptionPageDelegate:class {
    
    func optionPageClick(optionPage : SCOpitonPageView, index : Int)
    func optionPageScroll(optionPage : SCOpitonPageView, index : Int)
}

class SCOpitonPageView: UIView {

    weak var delegate: SCOptionPageDelegate?
    fileprivate var titles : [String]
    fileprivate var childVcs : [UIViewController]
    fileprivate var parentVc : UIViewController
    fileprivate var titleStyle : SCOptionPageStyle
    
    init(frame: CGRect, titles : [String], titleStyle : SCOptionPageStyle, childVcs : [UIViewController], parentVc : UIViewController) {
        
        self.titles = titles
        self.childVcs = childVcs
        self.parentVc = parentVc
        self.titleStyle = titleStyle
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension SCOpitonPageView{
    
    fileprivate func setupUI(){
        
        let titleViewFrame = CGRect(x: 0, y: 0, width: bounds.width, height: titleStyle.titleViewHeight)
        let titleView = SCTitleView(frame: titleViewFrame, titles: titles, style: titleStyle, superView: self)
        addSubview(titleView)
        
        let contentViewFrame = CGRect(x: 0, y: titleStyle.titleViewHeight, width: bounds.width, height: bounds.height - titleStyle.titleViewHeight)
        let contentView = SCContentView(frame: contentViewFrame, childVcs: childVcs, parentVc: parentVc, superView: self)
        addSubview(contentView)
        
        titleView.delegate = contentView
        contentView.delegate = titleView
    }
}
