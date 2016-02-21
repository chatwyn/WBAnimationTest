//
//  PresentFirstController.swift
//  WBAnimationTest
//
//  Created by caowenbo on 16/2/13.
//  Copyright © 2016年 曹文博. All rights reserved.
//

import UIKit

class PresentFirstController: UIViewController,UIGestureRecognizerDelegate{
    
    lazy var gesture:UIScreenEdgePanGestureRecognizer =  UIScreenEdgePanGestureRecognizer.init(target: self, action: Selector("RecognizerAction:"))
    
    // isPanGestureRecognizer是用来判断我是用手势还是用的按钮执行的present的动画
    private lazy var isPanGestureRecognizer = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.redColor()
        
        let btn = UIButton.init(type: .Custom)
        btn.size = CGSize(width: 200, height: 100)
        btn.center = view.center
        btn.setTitle("present", forState: .Normal)
        btn.addTarget(self, action: "present", forControlEvents: .TouchUpInside)
        view.addSubview(btn)
        
        
        let btn1 = UIButton.init(type: .Custom)
        btn1.size = CGSize(width: 200, height: 100)
        btn1.center = view.center
        btn1.center.y += 100
        btn1.setTitle("push", forState: .Normal)
        btn1.addTarget(self, action: "push", forControlEvents: .TouchUpInside)
        view.addSubview(btn1)
        
        self.view.addGestureRecognizer(gesture)
        gesture.edges = .Right
        
        self.navigationController?.delegate = self
        
    }
    
    func RecognizerAction(gesture:UIScreenEdgePanGestureRecognizer){
        
        // 只会调用一次
        if gesture.state != .Began{
            return
        }
        self.isPanGestureRecognizer = true
        
        let vc = PresentSecondController()
        vc.transitioningDelegate = self
        
        self.presentViewController(vc, animated: true, completion: nil)
        
    }
    
    func present() {
        
        self.isPanGestureRecognizer = false
        
        let vc = PresentSecondController()
        
        vc.transitioningDelegate = self
        
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    func push(){
        let vc = PresentSecondController()
        
        
        self.navigationController?.pushViewController(vc, animated: true)
        vc.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    
}


// MARK: - UIViewControllerTransitioningDelegate
extension PresentFirstController:  UIViewControllerTransitioningDelegate{
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        let animator = TransitionAnimator()
        
        animator.transition = .Present
        
        return animator
        
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        let animator = TransitionAnimator()
        
        animator.transition = .Dismiss
        
        return animator
    }
    
    func interactionControllerForPresentation(animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning?{
        // isPanGestureRecognizer是用来判断我是用手势还是用的按钮执行的present的动画
        return self.isPanGestureRecognizer ? InteractionController.init(gesture: self.gesture) : nil
        
    }
    
}

extension PresentFirstController: UINavigationControllerDelegate{
    
    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning?{
        
       
        if operation == .Push{
            let animator = TransitionAnimator()
            
            animator.transition = .Present
            
            return animator
        }else{
            if fromVC == self{
                return nil
            }
            let animator = TransitionAnimator()
            
            animator.transition = .Dismiss
            
            return animator
        }
        
    }
}


