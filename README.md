# SCOptionPage(swift)
类似于今日头条,斗鱼TV 选项卡界面(界面可以根据需求自行定制, 是否文字放大,是否滚动,是否有背景,颜色,大小都可根据需求自定制)
### 样式
![UI样式1](https://github.com/SCKaito/SCOptionPage/blob/master/image/1.gif)![UI样式2](https://github.com/SCKaito/SCOptionPage/blob/master/image/2.gif)![样式3](https://github.com/SCKaito/SCOptionPage/blob/master/image/3.gif)

### 代码
```
//let titles = ["推荐", "手游玩法大全", "娱乐手", "游戏游戏", "趣玩", "游戏游戏", "趣玩"]
let titles = ["推荐", "手游", "娱乐", "游戏", "趣玩"]
let style = SCOptionPageStyle()
style.titleViewHeight = 44
style.isScrollEnable = false
style.isTitleScale = false
style.isShowCoverView = false

var childVcs = [UIViewController]()
    for _ in 0..<titles.count {
    let vc = UIViewController()
    vc.view.backgroundColor = UIColor.randomColor()
    childVcs.append(vc)
}

let pageViewFrame = CGRect(x: 0, y: 64, width: view.bounds.width, height: view.bounds.height - 64 - 49)
let pageView = SCOpitonPageView(frame: pageViewFrame, titles: titles, titleStyle: style, childVcs: childVcs, parentVc: self)
pageView.delegate = self
view.addSubview(pageView)
```
添加代理来监听点击和滚动到第几个界面
```
extension ViewController: SCOptionPageDelegate {

    //选项卡点击
    func optionPageClick(optionPage : SCOpitonPageView, index : Int){

        print(optionPage)
        print(index)
    }
    //滚动类容视图
    func optionPageScroll(optionPage : SCOpitonPageView, index : Int){
        print(optionPage)
        print(index)
    }
}
```
