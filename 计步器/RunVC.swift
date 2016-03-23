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
  
    var time:NSTimeInterval?
    var timer:NSTimer!
  
    @IBOutlet var label: UILabel!

    @IBOutlet weak var intervarLabel: UILabel!

    @IBOutlet weak var timeView: UIView!
    

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
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "runback")!)
       
        self.timeView.layer.cornerRadius = 75
        self.timeView.layer.masksToBounds = true
        self.timeView.layer.borderColor = UIColor.greenColor().CGColor
        self.timeView.layer.borderWidth = 6
        self.timeView.backgroundColor = UIColor.blackColor()
     
        

        
        var mapView = UIView(frame: CGRect(x: 0, y: 20, width: Commen.ScreenWeight, height: Commen.ScrrenHeight/2-30))
        self.view.addSubview(mapView)
     
        self.mapVC = MapViewController()
        self.mapVC?.getMapView(mapView)
        
        self.label.layer.cornerRadius = 10
        self.label.layer.masksToBounds = true
        
        
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "refresh", userInfo: nil, repeats: true)
        

        
        
        
        
    
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        timer.fireDate = NSDate.distantPast()
    }

    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(true)
        
        timer.fireDate = NSDate.distantFuture()
    }
    
    
    
    func refresh(){
        
        time = NSDate().timeIntervalSinceDate(ce!.time!)
     
        
        print("____________")
         var   t = Int(time!)
       
        var h:Int = Int(t/3600) //时
        var s = Int(t%60) //秒
        var m = (t-s-3600*h)/60
        
      
        self.intervarLabel.text = "\(h):\(m):\(s)"
        
        
        
        
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
            self.timer.fireDate = NSDate.distantFuture()
            
            self.mVC.delegate!.stop!()
            self.navigationController?.popViewControllerAnimated(true)
 
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    

 

}
