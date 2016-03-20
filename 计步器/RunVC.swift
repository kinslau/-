//
//  RunVC.swift
//  计步器
//
//  Created by 移动互联网协会2 on 16/3/16.
//  Copyright © 2016年 ccsu. All rights reserved.
//

import UIKit

class RunVC: UIViewController,UIAlertViewDelegate {

    var ce:Cences?
    
    var location:Location?
    var mapVC:MapViewController?
  
    let mVC:Music = Music()

  
    @IBOutlet var label: UILabel!

    @IBOutlet var label2: UILabel!
    
    
    
    @IBAction func `switch`(sender: UISwitch) {
        
        if sender.on {
             mVC.delegate?.ControlPlay!(true)
        }else{
             mVC.delegate?.ControlPlay!(false)
        }
        
        
    }
    
    
    @IBAction func switch2(sender: UISwitch) {
        
        
        
    }
    
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        var mapView = UIView(frame: CGRect(x: 0, y: 20, width: Commen.ScreenWeight, height: Commen.ScrrenHeight/2-30))
        self.view.addSubview(mapView)
     
        self.mapVC = MapViewController()
        self.mapVC?.getMapView(mapView)
        
        self.label.layer.cornerRadius = 10
        self.label.layer.masksToBounds = true
        
        
        self.label2.layer.cornerRadius = 10
        self.label2.layer.masksToBounds = true
    
    }

    
    
  
    @IBAction func stopBtnClicked(sender: UIButton) {


        var alertView = UIAlertView(title: "停止运动", message: "是否停止运动", delegate: self, cancelButtonTitle: "取消", otherButtonTitles: "确定停止")
     
        alertView.show()
    }
    
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        
        switch buttonIndex{
        case 0: break
        default:
            location = Location.instance
            location?.stopLocation()

            ce!.interval = NSDate().timeIntervalSinceDate(ce!.time!)
         
            NSLog("相差%g秒", ce!.interval!)
            self.mVC.delegate!.stop!()
            self.navigationController?.popViewControllerAnimated(true)
 
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    

 

}
