//
//  SCOptionPageStyle.swift
//  SCOptionPage
//
//  Created by Kaito on 2018/1/18.
//  Copyright © 2018年 kaito. All rights reserved.
//

import UIKit

class SCOptionPageStyle: NSObject {
    
    var titleViewColor: UIColor = UIColor(r: 240, g: 240, b: 240)//titleView背景色
    var titleViewHeight : CGFloat = 50//titleView高度
    var titleFont : UIFont = UIFont.systemFont(ofSize: 15.0)//字体大小
    
    var isScrollEnable : Bool = false//能否滚动
    
    var normalColor : UIColor = UIColor(r: 0, g: 0, b: 0)//正常颜色
    var selectColor : UIColor = UIColor(r: 255, g: 127, b: 0)//选中颜色
    
    var titleMargin : CGFloat = 20//字体间距
    
    var isTitleScale : Bool = false//字体是否缩放
    var scaleRange : CGFloat = 1.2//缩放度
    
    var isShowBottomLine : Bool = true//是否显示滚动线
    var bottomLineColor : UIColor = UIColor(r: 255, g: 127, b: 0)//滚动线颜色
    var bottomLineHeight : CGFloat = 2//滚动线高度
    
    var isShowCoverView : Bool = false//是否有覆盖
    var coverBgColor : UIColor = UIColor.black//覆盖背景色
    var coverAlpha : CGFloat = 0.3//覆盖透明度
    var coverMargin : CGFloat = 8//覆盖间距
    var coverHeight : CGFloat = 25//覆盖高度
    
    
}
