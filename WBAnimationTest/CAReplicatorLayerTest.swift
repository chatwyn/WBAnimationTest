//
//  CAReplicatorLayerTest.swift
//  WBAnimationTest
//
//  Created by caowenbo on 16/2/1.
//  Copyright © 2016年 曹文博. All rights reserved.
//

import UIKit

class CAReplicatorLayerTest: UIViewController {
    
    let textPath = CAShapeLayer.init()
    // 复制层的layer
    let replicatorLayer = CAReplicatorLayer.init()
    // 被复制的的layer
    let replicatorView = CALayer.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.whiteColor()
        
        addTextPath()
        // 添加被复制的view
        addReplicatorView()
        // 添加副本layer
        addReplicatorLayer()

    }
    
    /**
     添加文字 chatwyn
     */
    func addTextPath() {
        
        let path = bezierPathFrom("chatwyn")
        textPath.frame = CGPathGetBoundingBox(path.CGPath)
        
        textPath.position = view.center
        textPath.geometryFlipped = true
        textPath.path = path.CGPath
        
        textPath.fillColor = nil
        textPath.lineWidth = 1
        textPath.strokeColor = nil
        
        self.view.layer.addSublayer(textPath)
    }
    
    /**
     添加被复制的View
     */
    func addReplicatorView() {
        
        replicatorView.frame = CGRectMake(34, 5,2, 2)
        replicatorLayer.cornerRadius = 1
        replicatorView.backgroundColor = UIColor.cyanColor().CGColor
        
    }
    /**
     添加副本layer
     */
    func addReplicatorLayer() {
        
        replicatorLayer.frame = textPath.bounds

        textPath.addSublayer(replicatorLayer)

        replicatorLayer.addSublayer(replicatorView)

        startAnimation()
        

        
    }
    
    func startAnimation() {
        // 副本数量(包括本身的一个)
        let replicatorCount = 500
        let duration:CFTimeInterval = 7
    
        replicatorLayer.instanceDelay = duration / CFTimeInterval(replicatorCount)
        replicatorLayer.instanceCount = replicatorCount

        replicatorLayer.instanceRedOffset = -0.003
        replicatorLayer.instanceGreenOffset = -0.003
        replicatorLayer.instanceBlueOffset = -0.001
        
        let positionAnmation = CAKeyframeAnimation.init(keyPath: "position")
        positionAnmation.path = textPath.path
        positionAnmation.duration = duration
        positionAnmation.repeatCount = MAXFLOAT
        // 如果在replicatorLayer上添加的话 只会做动画 并不会有延迟 
        // 需要添加到被复制的layer上才会有delay
        replicatorView.addAnimation(positionAnmation, forKey: "")
        
        
        
    }
    

    
    /**
     将字符串转变成贝塞尔曲线
     */
    func bezierPathFrom(string:String) -> UIBezierPath{
        
        let paths = CGPathCreateMutable()
        let fontName = __CFStringMakeConstantString("SnellRoundhand")
        let fontRef:AnyObject = CTFontCreateWithName(fontName, 110, nil)
        
        let attrString = NSAttributedString(string: string, attributes: [kCTFontAttributeName as String : fontRef])
        let line = CTLineCreateWithAttributedString(attrString as CFAttributedString)
        let runA = CTLineGetGlyphRuns(line)
        
        for (var runIndex = 0; runIndex < CFArrayGetCount(runA); runIndex++){
            let run = CFArrayGetValueAtIndex(runA, runIndex);
            let runb = unsafeBitCast(run, CTRun.self)
            
            let  CTFontName = unsafeBitCast(kCTFontAttributeName, UnsafePointer<Void>.self)
            
            let runFontC = CFDictionaryGetValue(CTRunGetAttributes(runb),CTFontName)
            let runFontS = unsafeBitCast(runFontC, CTFont.self)
            
            let width = UIScreen.mainScreen().bounds.width
            
            var temp = 0
            var offset:CGFloat = 0.0
            
            for(var i = 0; i < CTRunGetGlyphCount(runb); i++){
                let range = CFRangeMake(i, 1)
                let glyph:UnsafeMutablePointer<CGGlyph> = UnsafeMutablePointer<CGGlyph>.alloc(1)
                glyph.initialize(0)
                let position:UnsafeMutablePointer<CGPoint> = UnsafeMutablePointer<CGPoint>.alloc(1)
                position.initialize(CGPointZero)
                CTRunGetGlyphs(runb, range, glyph)
                CTRunGetPositions(runb, range, position);
                
                let temp3 = CGFloat(position.memory.x)
                let temp2 = (Int) (temp3 / width)
                let temp1 = 0
                if(temp2 > temp1){
                    
                    temp = temp2
                    offset = position.memory.x - (CGFloat(temp) * width)
                }
                let path = CTFontCreatePathForGlyph(runFontS,glyph.memory,nil)
                let x = position.memory.x - (CGFloat(temp) * width) - offset
                let y = position.memory.y - (CGFloat(temp) * 80)
                var transform = CGAffineTransformMakeTranslation(x, y)
                CGPathAddPath(paths, &transform, path)
                glyph.destroy()
                glyph.dealloc(1)
                position.destroy()
                position.dealloc(1)
            }
            
        }
        
        let bezierPath = UIBezierPath()
        bezierPath.moveToPoint(CGPointZero)
        bezierPath.appendPath(UIBezierPath(CGPath: paths))
        
        return bezierPath
    }
    
    
    
}
