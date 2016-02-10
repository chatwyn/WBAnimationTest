//
//  FoldAnimation.swift
//  WBAnimationTest
//
//  Created by caowenbo on 16/2/4.
//  Copyright © 2016年 曹文博. All rights reserved.
//

import UIKit

enum AnimationType{
    case Fold,Lanunch
}

class FoldAnimation: UIViewController {
    
    let perHeight = 100
    
    var lastType:AnimationType = .Lanunch
    
    var isAnimationing = false
    
    private lazy var views = {
        return [UIImageView]()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        let containerView = UIImageView.init(frame: CGRect(x: 40, y: 100, width: 300, height:4 * perHeight))
        self.view.addSubview(containerView)
        
        for  _ in 0 ..< 4{
            
            let view = UIImageView.init(image: UIImage.init(named: "8266801_1310119667018_1024x1024"))
            
            view.layer.anchorPoint = CGPoint(x: 0.5, y: 0)
            view.layer.contentsRect = CGRect(x: 0, y: 0.25 * CGFloat(views.count), width: 1, height: 0.25)
            
            view.layer.transform.m34 = -1/1000.0
            
            // 第一个添加到容器里 ，其他的添加到上一个view里边
            if views.count == 0{
                containerView.addSubview(view)
            }else{
                views.last!.addSubview(view)
            }
            
            let viewY = views.count == 0 ? 0 : perHeight
            view.frame = CGRect(x: 0, y: viewY, width: 300, height: perHeight)
            
            views.append(view)
        }
        
        let animationBtn = UIButton.init(type: .Custom)
        animationBtn.frame = CGRect(x: 150, y: 500, width: 100, height: 50)
        animationBtn.backgroundColor = UIColor.redColor()
        animationBtn.setTitle("开始动画", forState: .Normal)

        self.view.addSubview(animationBtn)
        
        animationBtn.addTarget(self, action: "animation", forControlEvents: .TouchUpInside)
    }
    
    func animation() {
        
        if isAnimationing{
            return
        }
        
        if lastType == .Lanunch{
            lastType = .Fold
        }else{
            lastType = .Lanunch
        }
        
        for (item,value) in views.enumerate(){
            
            if item == 0 {continue}
            
            addAnimation(value.layer, beginTime:item, animationType: lastType)
        }
        
    }
    
    func addAnimation(layer:CALayer,var beginTime:Int,animationType:AnimationType) {
        
        isAnimationing = true
        
        let animation = CABasicAnimation.init(keyPath: "transform.rotation.x")
        
        if animationType == .Lanunch{
            animation.setValue(NSString.init(format: "Lanunch%d", beginTime), forKey: "name")
            beginTime = beginTime - 1
        }else{
            animation.setValue(NSString.init(format: "Fold%d", beginTime), forKey: "name")
            beginTime = 3 - beginTime
        }
        
        animation.duration = 1
        
        animation.beginTime = CACurrentMediaTime() + NSTimeInterval(beginTime)
        
        animation.toValue = animationType == .Lanunch ? 0 : CGFloat(M_PI)
        // 动画结束不被移除 
        animation.fillMode = kCAFillModeForwards
        animation.removedOnCompletion = false
        animation.delegate  = self
        
        layer.addAnimation(animation, forKey: "")
        
    }
    
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        
        let name = anim.valueForKey("name") as! String
        
        if name == "Lanunch3" || name == "Fold1" {
            isAnimationing = false
        }
        
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillAppear(animated)
        
        views[1].layer.removeAllAnimations()
        views[2].layer.removeAllAnimations()
        views[3].layer.removeAllAnimations()
        
        
    }
    
}



