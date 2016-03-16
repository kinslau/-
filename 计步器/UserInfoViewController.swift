//
//  UserInfoViewController.swift
//  计步器
//
//  Created by 移动互联网协会2 on 16/3/15.
//  Copyright © 2016年 ccsu. All rights reserved.
//

import UIKit

class UserInfoViewController: UIViewController {

    @IBOutlet var photoImg: UIImageView!
    
    @IBAction func photoEditBtn(sender: UIButton) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigation()
        
        
        
    }
 
    private func setNavigation(){
        self.title = "编辑资料"
        self.photoImg.bounds = CGRect(x: 0, y: 0, width: 100, height: 100)
        self.photoImg.layer.cornerRadius = 65
        self.photoImg.layer.masksToBounds = true
        self.view.backgroundColor = UIColor.orangeColor()
        self.navigationItem.backBarButtonItem?.title = "Back"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Save, target: self, action: "save")

    }
    
    
    
    
    
    
    
    
    
    func save(){
        print("save")
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
      
    }
    


}
