//
//  CAShapeLayerTest.swift
//  WBAnimationTest
//
//  Created by caowenbo on 16/2/12.
//  Copyright © 2016年 曹文博. All rights reserved.
//

import UIKit

class CAShapeLayerTest: UIViewController {
    
    private let height:CGFloat = 200
    
    // 控制点1
    private let curve1 = UIView.init()
    // 控制点2
    private let curve2 = UIView.init()
    
    private let shapeLayer = CAShapeLayer.init()
    // 是否在正动画
    private var isAnimation = false
    
    private var displayLink:CADisplayLink?
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // 设置定时器
        displayLink = CADisplayLink.init(target: self, selector: "calculatePath")
        displayLink?.addToRunLoop(NSRunLoop.currentRunLoop(), forMode: NSDefaultRunLoopMode)
        displayLink?.paused = true
        
        // 添加控制点和layer
        addCurvePoint()
        
        // 计算layer的path
        calculatePath()
        
        setNaviBar()
        
        // 添加手势
        let gesture = UIPanGestureRecognizer.init(target: self, action: "panAction:")
        view.addGestureRecognizer(gesture)
        
        
    }
    
    // MARK: - event response
    func panAction(gesture:UIPanGestureRecognizer) {
        
        if(isAnimation == false){
            
            if (gesture.state == .Changed){
                
                let point = gesture.translationInView(view)
                
                curve1.y = point.y + height
                curve2.y = height - point.y
                
                curve1.x = kScreenWidth / 3.0 + point.x
                curve2.x = kScreenWidth  / 3.0 * 2.0 + point.x
                
                calculatePath()
                
            }else if(gesture.state == .Cancelled || gesture.state == .Ended || gesture.state == .Failed){
                
                isAnimation = true
                displayLink?.paused = false
                
                UIView.animateWithDuration(1.0,
                    delay: 0,
                    usingSpringWithDamping: 0.4,
                    initialSpringVelocity: 0,
                    options: .CurveEaseInOut,
                    animations: { () -> Void in
                        
                        self.curve1.frame = CGRectMake(self.view.frame.size.width / 3.0, self.height, 3, 3)
                        self.curve2.frame = CGRectMake(self.view.frame.size.width / 3.0 * 2.0, self.height, 3, 3)
                        
                    },
                    completion: { (finished:Bool) -> Void in
                        
                        if(finished == true){
                            
                            self.displayLink?.paused = true
                            self.isAnimation = false
                            
                        }
                        
                })
                
            }
        }
        
    }
    
    // MARK: - private method
    func addCurvePoint() {
        
        curve1.frame = CGRectMake(kScreenWidth / 3.0, height, 3, 3)
        curve1.backgroundColor = UIColor.clearColor()
        
        curve2.frame = CGRectMake(kScreenWidth / 3.0 * 2.0, height, 3, 3)
        curve2.backgroundColor = UIColor.clearColor()
        
        shapeLayer.fillColor = UIColor.redColor().CGColor
        view.layer.addSublayer(shapeLayer)
        
        view.addSubview(curve1)
        view.addSubview(curve2)
    }
    
    
    func calculatePath() {
        
        let path = UIBezierPath.init()
        
        path.moveToPoint(CGPoint(x: 0, y: 0))
        path.addLineToPoint(CGPoint(x: view.width, y: 0))
        path.addLineToPoint(CGPoint(x: view.width, y: height))
        //  更改控制点的位置  
        path.addCurveToPoint(CGPoint(x: 0, y: height), controlPoint1: curve1.layer.presentationLayer()?.position ?? curve1.center,controlPoint2: curve2.layer.presentationLayer()?.position ?? curve2.center)
        path.closePath()
        
        shapeLayer.path = path.CGPath
        
    }
    
    /**
     设置naviBar
     */
    func setNaviBar() {
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.navigationController?.navigationBarHidden = true
        
        let backBtn = UIButton.init(frame: CGRect(x: 10, y: 30, width: 50, height: 44))
        backBtn.setTitle("返回", forState: .Normal)
        backBtn.addTarget(self, action: "back", forControlEvents: .TouchUpInside)
        view.addSubview(backBtn)
        
    }
    
    func back() {
        self.navigationController?.navigationBarHidden = false
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
    
    
    
}
