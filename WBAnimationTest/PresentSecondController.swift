//
//  PresentSecondController.swift
//  WBAnimationTest
//
//  Created by caowenbo on 16/2/13.
//  Copyright © 2016年 曹文博. All rights reserved.
//

import UIKit

class PresentSecondController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.lightGrayColor()
        
        let btn = UIButton.init(type: .Custom)
        btn.size = CGSize(width: 200, height: 100)
        btn.center = view.center
        btn.setTitle("dismiss", forState: .Normal)
        btn.addTarget(self, action: "dismiss", forControlEvents: .TouchUpInside)
        
        view.addSubview(btn)
        
        self.title = "test"

    }
    
    func dismiss() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    

}
