//
//  InteractionController.swift
//  WBAnimationTest
//
//  Created by caowenbo on 16/2/14.
//  Copyright © 2016年 曹文博. All rights reserved.
//

import UIKit

class InteractionController: UIPercentDrivenInteractiveTransition {
    
    var transitionContext: UIViewControllerContextTransitioning? = nil
    var gesture: UIScreenEdgePanGestureRecognizer
    
    init(gesture: UIScreenEdgePanGestureRecognizer) {
        
        self.gesture = gesture
        
        super.init()
        self.gesture.addTarget(self, action: "gestureAction:")
    }
    
    override func startInteractiveTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        self.transitionContext = transitionContext
        
        super.startInteractiveTransition(transitionContext)
    }
    

    private func percentForGesture(gesture: UIScreenEdgePanGestureRecognizer) -> CGFloat {
        let transitionContainerView = transitionContext?.containerView()
        let locationInSourceView = gesture.locationInView(transitionContainerView)
        
        let width = transitionContainerView!.bounds.width
        
        return (width - locationInSourceView.x) / width
        
    }
    
    /// 当手势有滑动时触发这个函数
    func gestureAction(gestureRecognizer: UIScreenEdgePanGestureRecognizer) {
        switch gestureRecognizer.state {
        case .Began: break
        case .Changed: self.updateInteractiveTransition(self.percentForGesture(gesture))  //更新进度
        case .Ended:
            // 手势滑动超过5分之一的时候完成转场
            if self.percentForGesture(gestureRecognizer) >= 0.2 {
                self.finishInteractiveTransition()
            }else {
                self.cancelInteractiveTransition()
            }
        default: self.cancelInteractiveTransition()
            
        }
    }
}

