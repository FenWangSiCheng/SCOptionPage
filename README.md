# SCOptionPage
类似于今日头条,斗鱼TV 选项卡界面(界面可以根据需求自行定制, 是否放大)
![UI样式1](https://github.com/SCKaito/SCOptionPage/blob/master/image/option1.gif)![UI样式2](https://github.com/SCKaito/SCOptionPage/blob/master/image/option2.gif)

### 设置
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
view.addSubview(pageView)
```
