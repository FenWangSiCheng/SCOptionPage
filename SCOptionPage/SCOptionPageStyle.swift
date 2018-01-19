//
//  SCOptionPageStyle.swift
//  SCOptionPage
//
//  Created by Kaito on 2018/1/18.
//  Copyright © 2018年 kaito. All rights reserved.
//

import UIKit

class SCOptionPageStyle: NSObject {

    var titleViewHeight : CGFloat = 50
    var titleFont : UIFont = UIFont.systemFont(ofSize: 15.0)
    
    var isScrollEnable : Bool = false
    
    var normalColor : UIColor = UIColor(r: 0, g: 0, b: 0)
    var selectColor : UIColor = UIColor(r: 255, g: 127, b: 0)
    
    var titleMargin : CGFloat = 20
    
    var isTitleScale : Bool = false
    var scaleRange : CGFloat = 1.2
    
    var isShowBottomLine : Bool = true
    var bottomLineColor : UIColor = UIColor(r: 255, g: 127, b: 0)
    var bottomLineHeight : CGFloat = 2
    
    var isShowCoverView : Bool = false
    var coverBgColor : UIColor = UIColor.black
    var coverAlpha : CGFloat = 0.3
    var coverMargin : CGFloat = 8
    var coverHeight : CGFloat = 25
    
    var titleViewColor: UIColor = UIColor(r: 240, g: 240, b: 240)
}
