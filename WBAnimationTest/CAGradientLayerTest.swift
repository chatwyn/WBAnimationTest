//
//  CAGradientLayerTest.swift
//  WBAnimationTest
//
//  Created by caowenbo on 16/2/2.
//  Copyright © 2016年 曹文博. All rights reserved.
//

import UIKit

class CAGradientLayerTest: UIViewController {
    
    let layer = CAGradientLayer.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        // 颜色数组
        layer.colors = [UIColor.redColor().CGColor,UIColor.greenColor().CGColor,UIColor.yellowColor().CGColor]
        // 颜色的方向
        layer.startPoint = CGPointZero
        layer.endPoint = CGPoint(x: 1, y: 1)
        
        // 0 - 0.3 红色 0.3 - 0.5 红绿渐变色。0.5-0.8绿黄渐变 0.8 -1 黄色
        layer.locations = [0.3,0.5,0.8]
        
        layer.frame = self.view.bounds
        
        self.view.layer.addSublayer(layer)
        
        
        // 动画之后的颜色数组
        let toColors = [UIColor.whiteColor().CGColor,UIColor.cyanColor().CGColor,UIColor.purpleColor().CGColor]
        
        let animation = CABasicAnimation.init(keyPath: "colors")
        
        animation.duration = 1.0
        animation.toValue = toColors
        animation.repeatCount = MAXFLOAT
        
        //  动画结束后，再动画回来
        animation.autoreverses = true
        
        layer.addAnimation(animation, forKey: "color")
        
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        layer.removeAllAnimations()
    }
    
}
