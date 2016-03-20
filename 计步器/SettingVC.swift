//
//  SettingVC.swift
//  计步器
//
//  Created by 移动互联网协会2 on 16/3/17.
//  Copyright © 2016年 ccsu. All rights reserved.
//

import UIKit

class SettingVC: UIViewController,UITableViewDataSource,UITableViewDelegate {

    
    
    var arrar:NSArray?
    
    @IBOutlet var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableview.delegate = self
        self.title = "设置"
        arrar = ["功能介绍","注意事项","版本更新"]

    }

    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        var cellId = "sundycell"
        var cell:UITableViewCell? = tableView.dequeueReusableCellWithIdentifier(cellId)
        
        
        //如果不存在该实例
        
        if cell == nil {
            
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellId)
            
        }

        cell?.textLabel?.text =  arrar![indexPath.row] as! String
        cell?.accessoryType = UITableViewCellAccessoryType.None
        
        
        return cell!

    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrar!.count
        
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        print("——————————你点击了第\(indexPath.row)行——————————")
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    
   

}
