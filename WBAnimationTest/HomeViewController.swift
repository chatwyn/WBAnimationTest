//
//  HomeViewController.swift
//  WBAnimationTest
//
//  Created by caowenbo on 16/2/1.
//  Copyright © 2016年 曹文博. All rights reserved.
//

import UIKit

class HomeViewController: UITableViewController {

    let array = [NSStringFromClass(CAReplicatorLayerTest),NSStringFromClass(CAGradientLayerTest),NSStringFromClass(FoldAnimation),NSStringFromClass(CAShapeLayerTest),NSStringFromClass(PresentFirstController)]
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    
    // MARK: - Table view data source
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return array.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)

        cell.textLabel?.text = array[indexPath.row].componentsSeparatedByString(".").last

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        var vc:UIViewController?
        
        let type = NSClassFromString(array[indexPath.row]) as! UIViewController.Type
        vc =  type.init()
        navigationController?.pushViewController(vc!, animated: true)
    }
    
    
}
