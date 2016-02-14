//
//  TransitionAnimator.swift
//  WBAnimationTest
//
//  Created by caowenbo on 16/2/13.
//  Copyright © 2016年 曹文博. All rights reserved.
//

import UIKit

enum ModalTransition{
    case Present
    case Dismiss
}

class TransitionAnimator: NSObject,UIViewControllerAnimatedTransitioning {

    var toViewController:UIViewController?
    
    var transition:ModalTransition = .Present
    
    //当vc.modalPresentationStyle为custom的时候需要实现
//    func animationEnded(transitionCompleted: Bool) {
//        toViewController?.endAppearanceTransition()
//    }
    
    // 持续时间
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval{
        
        return 2.0
    }
    
    //  转场动画具体的实现
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        //                    present  dismiss
        // fromViewController    A        B
        // toViewController      B        A
        
        let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
        toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
        // 转成动画中的容器View
        let containerView = transitionContext.containerView()
        
        let fromView = fromViewController?.view
        let toView = toViewController?.view
        
        //  transition 是自己写的属性，用来分别是present和Dismiss
        if self.transition == .Present{
            
            presentAnimation(transitionContext, fromView: fromView!, toView: toView!, containerView: containerView!,fromController: fromViewController!, toController: toViewController!)
            
        }else{
            
            dismissAnimation(transitionContext, fromView: fromView!, toView: toView!, containerView: containerView!, fromController: fromViewController!, toController: toViewController!)
        }
        
//        toViewController?.beginAppearanceTransition(true, animated: true)
        
    }
    
    // present的动画
    func presentAnimation(transitionContext:UIViewControllerContextTransitioning,fromView:UIView,toView:UIView,containerView:UIView,fromController:UIViewController,toController:UIViewController){
        
        // 设置B控制器的锚点为右上角
        toView.layer.anchorPoint = CGPoint(x: 1, y: 0)
        // 可以获得B控制器最终的frame
        toView.frame = transitionContext.finalFrameForViewController(toController)
        // 将B控制器的View 添加的containerView上
        containerView.addSubview(toView)
        
        // 使B控制器逆时针旋转90度
        toView.layer.transform = CATransform3DMakeRotation(-CGFloat(M_PI_2), 0, 0, 1)
        toView.alpha = 0
        
        let transitionDuration = self.transitionDuration(transitionContext)
        
        // 弹性动画
        UIView.animateWithDuration(transitionDuration,  // 持续时间
            delay: 0,  // 延迟多久执行
            usingSpringWithDamping: 0.6, // 弹性强度
            initialSpringVelocity: 0,  // 初始速度
            options: .CurveLinear,  // 弹性方案
            animations: { () -> Void in
                
                toView.alpha = 1
                toView.layer.transform = CATransform3DIdentity
                
            }) { (finished: Bool) -> Void in
                //再完成之后，记得去实现转场动画结束的方法
                let wasCancelled = transitionContext.transitionWasCancelled()
                transitionContext.completeTransition(!wasCancelled)
        }
        
    }
    
    func dismissAnimation(transitionContext:UIViewControllerContextTransitioning,fromView:UIView,toView:UIView,containerView:UIView,fromController:UIViewController,toController:UIViewController){
        
        let transitionDuration = self.transitionDuration(transitionContext)
        
        containerView.insertSubview(toView, belowSubview: fromView)
        
        UIView.animateWithDuration(transitionDuration * 0.5, animations: { () -> Void in
            
            fromView.layer.transform = CATransform3DMakeRotation(-CGFloat(M_PI_2), 0, 0, 1)
            fromView.alpha = 0
            
            }) { (finished: Bool) -> Void in
                
                let wasCancelled = transitionContext.transitionWasCancelled()
                transitionContext.completeTransition(!wasCancelled)
        }
       
        
    }

}
