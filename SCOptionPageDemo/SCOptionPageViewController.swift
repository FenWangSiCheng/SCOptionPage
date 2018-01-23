//
//  SCOptionPageViewController.swift
//  SCOptionPageDemo
//
//  Created by abon on 2018/1/23.
//  Copyright © 2018年 kaito. All rights reserved.
//

import UIKit

class SCOptionPageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let titles = ["推荐", "手游玩法大全", "娱乐手", "游戏游戏", "趣玩", "游戏游戏", "趣玩"]
        //let titles = ["推荐", "手游", "娱乐", "游戏", "趣玩"]
        let style = SCOptionPageStyle()
        style.titleViewHeight = 44
        style.isScrollEnable = true
        style.isTitleScale = true
        style.isShowCoverView = true
        
        var childVcs = [UIViewController]()
        for _ in 0..<titles.count {
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor.randomColor()
            childVcs.append(vc)
        }
        
        let pageViewFrame = CGRect(x: 0, y: 64, width: view.bounds.width, height: view.bounds.height - 64 - 49)
        let pageView = SCOpitonPageView(frame: pageViewFrame, titles: titles, titleStyle: style, childVcs: childVcs, parentVc: self)
        view.addSubview(pageView)
    }

 
}
