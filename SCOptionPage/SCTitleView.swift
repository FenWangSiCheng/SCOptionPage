//
//  SCTitleView.swift
//  SCOptionPage
//
//  Created by Kaito on 2018/1/18.
//  Copyright © 2018年 kaito. All rights reserved.
//

import UIKit

protocol SCTitleViewDeleate : class {
    func titleView(titleView : SCTitleView, currentIndex : Int)
}

class SCTitleView: UIView {

    weak var delegate : SCTitleViewDeleate?
    
    fileprivate var titles : [String]
    fileprivate var style : SCOptionPageStyle
    fileprivate  var superView: SCOpitonPageView
    fileprivate lazy var currentIndex : Int = 0
    fileprivate lazy var titleLabels : [UILabel] = [UILabel]()
    fileprivate lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView(frame: self.bounds)
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        return scrollView
    }()
    
    fileprivate lazy var bottomLine : UIView = {
        let bottomLine = UIView()
        bottomLine.backgroundColor = self.style.bottomLineColor
        bottomLine.frame.size.height = self.style.bottomLineHeight
        return bottomLine
    }()
    
    fileprivate lazy var coverView : UIView = {
        let coverView = UIView()
        coverView.backgroundColor = self.style.coverBgColor
        coverView.alpha = self.style.coverAlpha
        return coverView
    }()
    
    init(frame: CGRect, titles:[String], style:SCOptionPageStyle, superView:SCOpitonPageView) {
        self.titles = titles
        self.style = style
        self.superView = superView
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - UI界面
extension SCTitleView {

    fileprivate func setupUI() {
        
        backgroundColor = self.style.titleViewColor
        
        addSubview(scrollView)
        
        setupTitleLabels()
        
        setupTitleLabelsFrame()
        
        setupBottomLine()
        
        setupCoverView()
    }
    
    private func setupTitleLabels() {
        for (i, title) in titles.enumerated() {
            let titleLabel = UILabel()
            
            titleLabel.text = title
            titleLabel.tag = i
            titleLabel.font = style.titleFont
            titleLabel.textColor = i == 0 ? style.selectColor : style.normalColor
            titleLabel.textAlignment = .center
            
            scrollView.addSubview(titleLabel)
        
            titleLabels.append(titleLabel)
            
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(titleLabelClick(_:)))
            titleLabel.addGestureRecognizer(tapGes)
            titleLabel.isUserInteractionEnabled = true
        }
    }
    
    private func setupTitleLabelsFrame() {
        let count = titles.count
        
        for (i, label) in titleLabels.enumerated() {
            var w : CGFloat = 0
            let h : CGFloat = bounds.height
            var x : CGFloat = 0
            let y : CGFloat = 0
            
            if !style.isScrollEnable {
                w = bounds.width / CGFloat(count)
                x = w * CGFloat(i)
            } else {
                w = (titles[i] as NSString).boundingRect(with: CGSize(width : CGFloat.greatestFiniteMagnitude, height: 0), options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font : style.titleFont], context: nil).width
                if i == 0 {
                    x = style.titleMargin * 0.5
                } else {
                    let preLabel = titleLabels[i - 1]
                    x = preLabel.frame.maxX + style.titleMargin
                }
            }
    
            label.frame = CGRect(x: x, y: y, width: w, height: h)
            
            if style.isTitleScale && i == 0 {
                label.transform = CGAffineTransform(scaleX: style.scaleRange, y: style.scaleRange)
            }
        }
        
        if style.isScrollEnable {
            scrollView.contentSize.width = titleLabels.last!.frame.maxX + style.titleMargin * 0.5
        }
    }
    
    private func setupBottomLine() {
       
        guard style.isShowBottomLine else { return }
        
        scrollView.addSubview(bottomLine)
        
        if !style.isScrollEnable {
            bottomLine.frame.origin.x = 0
            bottomLine.frame.size.width = bounds.width / CGFloat(titles.count)
        } else {

            bottomLine.frame.origin.x = style.titleMargin * 0.5
            bottomLine.frame.size.width = (titles[0] as NSString).boundingRect(with: CGSize(width : CGFloat.greatestFiniteMagnitude, height: 0), options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font : style.titleFont], context: nil).width
        }
        bottomLine.frame.origin.y = bounds.height - style.bottomLineHeight
    }
    
    private func setupCoverView() {

        guard style.isShowCoverView else { return }
        
        scrollView.addSubview(coverView)
        
        var coverW : CGFloat = titleLabels.first!.frame.width - 2 * style.coverMargin
        if style.isScrollEnable {
            coverW = titleLabels.first!.frame.width + style.titleMargin * 0.5
        }
        let coverH : CGFloat = style.coverHeight
        coverView.bounds = CGRect(x: 0, y: 0, width: coverW, height: coverH)
        coverView.center = titleLabels.first!.center
        
        coverView.layer.cornerRadius = style.coverHeight * 0.5
        coverView.layer.masksToBounds = true
    }
   
}

//MARK:- 事件处理函数
extension SCTitleView {
    @objc fileprivate func titleLabelClick(_ tapGes : UITapGestureRecognizer) {
        guard let newLabel = tapGes.view as? UILabel else { return }
        
        superView.delegate?.optionPageClick(optionPage: superView, index: newLabel.tag)
        
        guard currentIndex != newLabel.tag else {
            return
        }
       
        let oldLabel = titleLabels[currentIndex]
        oldLabel.textColor = style.normalColor
        newLabel.textColor = style.selectColor
        currentIndex = newLabel.tag
        
        adjustBottomLine(newLabel: newLabel, oldLabel: oldLabel)
        
        adjustScale(newLabel: newLabel, oldLabel: oldLabel)
        
        adjustPosition(newLabel)
        
        adjustCover(newLabel: newLabel)
        
        delegate?.titleView(titleView: self, currentIndex: currentIndex)
    }
    
    fileprivate func adjustCover(newLabel: UILabel){
        if style.isShowCoverView {
            let coverW = style.isScrollEnable ? (newLabel.frame.width + style.titleMargin) : (newLabel.frame.width - 2 * style.coverMargin)
            UIView .animate(withDuration: 0.2, animations: {
                self.coverView.frame.size.width = coverW
                self.coverView.center = newLabel.center
            })
        }
    }
    
    fileprivate func adjustBottomLine(newLabel: UILabel, oldLabel: UILabel) {
        if style.isShowBottomLine {
            let deltaX = newLabel.frame.origin.x - oldLabel.frame.origin.x
            let deltaW = newLabel.frame.width - oldLabel.frame.width
            UIView.animate(withDuration: 0.2, animations: {
                self.bottomLine.frame.origin.x = oldLabel.frame.origin.x + deltaX
                self.bottomLine.frame.size.width = oldLabel.frame.width + deltaW
            })
        }
    }
    
    fileprivate func adjustScale(newLabel: UILabel, oldLabel:UILabel) {
        if style.isTitleScale {
            UIView.animate(withDuration: 0.2, animations: {
                newLabel.transform = oldLabel.transform
                oldLabel.transform = CGAffineTransform.identity
            })
            
        }
    }
    
    fileprivate func adjustPosition(_ newLabel : UILabel) {
        guard style.isScrollEnable else { return }
        var offsetX = newLabel.center.x - scrollView.bounds.width * 0.5
        if offsetX < 0 {
            offsetX = 0
        }
        let maxOffset = scrollView.contentSize.width - bounds.width
        if offsetX > maxOffset {
            offsetX = maxOffset
        }
        scrollView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
}

//MARK: - SCContentViewDelegate
extension SCTitleView : SCContentViewDelegate {
    func contentView(contentView: SCContentView, inIndex: Int) {
  
        guard inIndex != currentIndex else {
            return
        }
        
        let oldLabel = titleLabels[currentIndex]
        let newLabel = titleLabels[inIndex]
        
        oldLabel.textColor = style.normalColor
        newLabel.textColor = style.selectColor
        
        currentIndex = inIndex
        
        adjustBottomLine(newLabel: newLabel, oldLabel: oldLabel)
        
        adjustScale(newLabel: newLabel, oldLabel: oldLabel)
        
        adjustPosition(newLabel)
        
        adjustCover(newLabel: newLabel)
    }
    
}

