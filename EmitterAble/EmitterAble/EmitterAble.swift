//
//  EmitterAble.swift
//  LiveProduct
//
//  Created by kaito on 2018/1/23.
//  Copyright © 2018年 kaito. All rights reserved.
//

import UIKit


/// 粒子效果
protocol EmitterAble {
    
    //var emiiter: CAEmitterLayer
    
}

extension EmitterAble where Self : UIViewController {
    
    
    
    /// 开启粒子效果
    func start(position: CGPoint) {
        
        // 1.创建发射器
        let emitter = CAEmitterLayer()
        
        // 2.设置发射器的位置
        emitter.emitterPosition = CGPoint(x: view.bounds.width * 0.5, y: -60)
        
        // 3.开启三维效果
        emitter.preservesDepth = true
        
        // 4.创建例子, 并且设置例子相关的属性
        // 4.1.创建例子Cell
        let cell = CAEmitterCell()
        
        // 4.2.设置粒子速度
        cell.velocity = 150
        //cell.velocityRange = 100
        
        // 4.3.设置例子的大小
        cell.scale = 0.7
        //cell.scaleRange = 0.3
        
        // 4.4.设置粒子方向
        cell.emissionLongitude = CGFloat(Double.pi * 0.5)
        //cell.emissionRange = CGFloat(Double.pi * 0.25)
        
        // 4.5.设置例子的存活时间
        cell.lifetime = 6
        //cell.lifetimeRange = 1.5
        
        // 4.6.设置粒子旋转
        cell.spin = CGFloat(Double.pi * 0.5)
        //cell.spinRange = CGFloat(Double.pi * 0.25)
        
        // 4.6.设置例子每秒弹出的个数
        cell.birthRate = 1
        cell.repeatCount = 1
        
        // 4.7.设置粒子展示的图片
        cell.contents = UIImage(named: "good6_30x30")?.cgImage
        
        // 5.将粒子设置到发射器中
        emitter.emitterCells = [cell]
        
        // 6.将发射器的layer添加到父layer中
        view.layer.addSublayer(emitter)
    }
    
    //停止粒子效果
    func stop() {
       
        view.layer.sublayers?.filter({ $0.isKind(of: CAEmitterLayer.self)}).first?.removeFromSuperlayer()
    }
}
