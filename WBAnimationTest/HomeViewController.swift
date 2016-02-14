//
//  HomeViewController.swift
//  WBAnimationTest
//
//  Created by caowenbo on 16/2/1.
//  Copyright © 2016年 曹文博. All rights reserved.
//

import UIKit

class HomeViewController: UITableViewController {
    
    let array = [String(CAReplicatorLayerTest),String(CAGradientLayer),String(FoldAnimation),String(CAShapeLayerTest),String(PresentFirstController)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Table view data source
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return array.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)

        cell.textLabel?.text = array[indexPath.row]

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        var vc:UIViewController?

        switch (indexPath.row){
        case 0 :vc = CAReplicatorLayerTest()
        case 1 :vc = CAGradientLayerTest()
        case 2 :vc = FoldAnimation()
        case 3 :vc = CAShapeLayerTest()
        case 4 :vc = PresentFirstController()
        default: return
        }
        navigationController?.pushViewController(vc!, animated: true)
    }
    
    
}
