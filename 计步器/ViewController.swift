//
//  ViewController.swift
//  计步器
//
//  Created by 移动互联网协会2 on 16/3/13.
//  Copyright © 2016年 ccsu. All rights reserved.
//

import UIKit

import CoreLocation



class ViewController: UIViewController,PassValueLocationDelegate,SideMenuDelegate,ABCIntroViewDelegate {
   
    var location:Location!
    var sideMenu:SideMenu?
  
    var introView:ABCIntroView?
   
    
    @IBOutlet var label1: UILabel!
   
    @IBOutlet var label2: UILabel!

    @IBOutlet var backView:UIView!
    
    @IBAction func letfItemClicked(sender: UIBarButtonItem) {
        self.navigationController?.pushViewController(UserInfoViewController(), animated: true)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
     
        var defaults:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        if defaults.objectForKey("首次进入") == nil{
            
            self.navigationController?.navigationBarHidden = true
            
            introView = ABCIntroView(frame: self.view.frame)
            introView?.delegate = self
            introView?.backgroundColor = UIColor.greenColor()
            self.view.addSubview(introView!)
            
            
        }else{
            print("非首次")
            self.navigationController?.navigationBarHidden = false
            
        }
        

        sideMenu = SideMenu(sourceView: self.view, menuData: ["定位","地图","统计"])
        sideMenu?.delegate = self
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "image")!)
       location = Location()
        location.delegate = self
       

        
//        var MapView = MapViewController()
//        MapView.initWithView(self.backView)
        
    }
    
    

    //ABCIntroView代理
    func onDoneButtonPressed(){
        var defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject("非首次", forKey: "首次进入")
        defaults.synchronize()
        UIView.animateWithDuration(1, delay: 0, options: .CurveEaseInOut, animations: { () -> Void in
            
            self.introView?.alpha = 0
            
            }) { (finish) -> Void in
                //动画完成后
                self.introView?.removeFromSuperview()
                self.navigationController?.navigationBarHidden = false
        }

    }
    
 
   //VC单例模式
    static func sharedInstance()->ViewController{
        let story:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc:ViewController = story.instantiateViewControllerWithIdentifier("ViewController") as! ViewController
        
        return self as! ViewController
    }
    
    private init(){
        super.init(nibName: nil, bundle: nil)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nil, bundle: nil)
        
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    
    @IBAction func run(sender: UIButton) {
        location.startLocation()
        
        // 开始跑步操作
        
    
    }


    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

   
    //自定义定位代理
    func passValueWithGeo(latitude:CLLocationDegrees,longitude:CLLocationDegrees){
     
        print("__________________________")
        self.label1.text = "\(latitude)"
        self.label2.text = "\(longitude)"

    }
    

 
    //SideMenu代理
    func sideMenuDidSelectItemAtIndex(index: Int) {
        switch index{
        case 0:
            self.navigationController?.pushViewController(UserInfoViewController(), animated: true)
      
        case 1:
            self.navigationController?.pushViewController(MapViewController(), animated: false)
        default:
            self.navigationController?.pushViewController(MapViewController(), animated: false)

        }
    }

}
