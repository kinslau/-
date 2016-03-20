//
//  ViewController.swift
//  计步器
//
//  Created by 移动互联网协会2 on 16/3/13.
//  Copyright © 2016年 ccsu. All rights reserved.


import UIKit

import CoreLocation

class ViewController: UIViewController,PassValueLocationDelegate,SideMenuDelegate,ABCIntroViewDelegate {
   
    var ce:Cences?
    let runVc:RunVC = RunVC()
    var location:Location!
    var sideMenu:SideMenu?
    var introView:ABCIntroView?
    var chartView:CBChartView?
 
    @IBOutlet var statusView: UIView!
    @IBOutlet var headImg: UIImageView!
    
    @IBOutlet var infoView: UIView!
    
    
  
    @IBAction func headBtn(sender: UIButton) {
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.backgroundColor = UIColor.greenColor()
        self.judgeIsFirstInto()

        
        self.infoView.layer.cornerRadius = 10
        self.headImg.layer.cornerRadius = 40
        self.headImg.layer.masksToBounds = true
        
        self.statusView.layer.cornerRadius = 10
        self.statusView.backgroundColor = UIColor.greenColor()
        self.statusView.alpha = 0.8

        
        
     //   var nib = UINib(nibName: "RunVC", bundle: nil)
        
        //registerNib
    }
    

    
    
    func setChartView(){
        self.chartView = CBChartView()
        self.chartView?.backgroundColor = UIColor.blackColor()
        self.chartView?.frame = CGRect(x: 0, y: Commen.ScrrenHeight/3, width: Commen.ScreenWeight, height: Commen.ScrrenHeight/3)
        self.chartView?.xValues = ["0","9","10","11","12","13","14","15","16"]
        self.chartView?.yValues = ["75","25","60","53","30","21","36","84","22"]
        self.chartView?.chartColor = UIColor.greenColor()
        self.view.addSubview(chartView!)
        
    }

    
    func Configure(){
        sideMenu = SideMenu(sourceView: self.view, menuData: ["地图","记录","设置","关于"])
        sideMenu?.delegate = self

        location = Location.instance
        location.delegate = self
    }
    

    
    
    
    func judgeIsFirstInto(){
        var defaults:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        if defaults.objectForKey("首次进入") == nil{

            self.navigationController?.navigationBarHidden = true
            
            introView = ABCIntroView(frame: self.view.frame)
            introView?.backgroundColor = UIColor.grayColor()
            introView?.delegate = self
            
            self.view.addSubview(introView!)

        }else{
           
            self.navigationController?.navigationBarHidden = false
            self.setChartView()
            self.Configure()
        }
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
                self.setChartView()
                self.Configure()
        }

    }
    

    @IBAction func run(sender: UIButton) {
        
        location.startLocation()
        location.clManager.requestWhenInUseAuthorization()
        
        
        runVc.ce = Cences()
        runVc.ce!.time = NSDate()
        runVc.ce!.loca = location.loca
        self.navigationController?.pushViewController(runVc, animated: true)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    //自定义定位代理
    func passValueWithGeo(latitude:CLLocationDegrees,longitude:CLLocationDegrees){

    }
    
    //SideMenu代理
    func sideMenuDidSelectItemAtIndex(index: Int) {
        switch index{
        case 0:
            self.navigationController?.pushViewController(MapViewController(), animated: false)
        case 1:
            self.navigationController?.pushViewController(MapViewController(), animated: true)
        case 2:
            self.navigationController?.pushViewController(SettingVC(), animated: true)
        case 3:
            self.navigationController?.pushViewController(SettingVC(), animated: true)
        default:
            self.navigationController?.pushViewController(SettingVC(), animated: true)
            
        }
        
    }

}