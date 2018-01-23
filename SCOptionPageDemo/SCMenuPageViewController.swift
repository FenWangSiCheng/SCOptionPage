//
//  SCMenuPageViewController.swift
//  SCOptionPageDemo
//
//  Created by abon on 2018/1/23.
//  Copyright © 2018年 kaito. All rights reserved.
//

import UIKit

private let kEmoticonCell = "kEmoticonCell"

class SCMenuPageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let pageFrame = CGRect(x: 0, y: 100, width: view.bounds.width, height: 300)
        
        let titles = ["土豪", "热门", "专属", "常见"]
        let style = SCOptionPageStyle()
        style.isShowBottomLine = true
        
        let layout = SCMenuPageCollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.cols = 4
        layout.rows = 2
        
        let pageCollectionView = SCMenuPageView(frame: pageFrame, titles: titles, style: style, isTitleInTop: true, layout: layout)
        pageCollectionView.dataSource = self 
        pageCollectionView.register(cell: UICollectionViewCell.self, identifier: kEmoticonCell)
        pageCollectionView.backgroundColor = UIColor.orange
        view.addSubview(pageCollectionView)
    }
    
}


extension SCMenuPageViewController : SCMenuPageViewDataSource {
    
    func numberOfSections(_ menuPageView: SCMenuPageView) -> Int {
        return 2
    }
    func pageCollectionView(_ menuPageView: SCMenuPageView, numberOfItemsInSection section: Int) -> Int {
        
        if section == 0 {
            return 20
        }else {
            return 14
        }
    }
    
    func pageCollectionView(_ menuPageView: SCMenuPageView, _ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kEmoticonCell, for: indexPath)
        
        cell.backgroundColor = UIColor.randomColor()
        
        return cell
    }
    
   
}
