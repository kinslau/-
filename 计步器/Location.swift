//
//  Location.swift
//  计步器
//
//  Created by 移动互联网协会2 on 16/3/13.
//  Copyright © 2016年 ccsu. All rights reserved.
//

import UIKit
import CoreLocation


@objc protocol PassValueLocationDelegate:NSObjectProtocol{
    func passValueWithGeo(latitude:CLLocationDegrees,longitude:CLLocationDegrees)
}

class Location: NSObject,CLLocationManagerDelegate{
    

    var delegate:PassValueLocationDelegate?
    var clManager:CLLocationManager!
 
    var geocoder:CLGeocoder!
    
    override  init() {
        super.init()
            clManager = CLLocationManager()
            clManager.requestAlwaysAuthorization()
            print("Location初始化完成")
        
            clManager.desiredAccuracy = kCLLocationAccuracyBest
            clManager.distanceFilter = 10  //1米定位以此
            geocoder = CLGeocoder()
            clManager.delegate = self
            //self.delegate = ViewController.sharedInstance()
   
    }

    //反地理编码
    func getAddressByLatitude(latitude:CLLocationDegrees,longitude:CLLocationDegrees){
        
        print("进行反地理编码")
        var location = CLLocation(latitude: latitude, longitude: longitude)
        geocoder.reverseGeocodeLocation(location) { (placemarks, error)-> Void in
            
            if placemarks != nil{
                var placemark:CLPlacemark  = placemarks!.first!
                NSLog("_______________________________")
                NSLog("详细信息:%@",placemark.addressDictionary!)
                var dict:NSDictionary = placemark.addressDictionary as! NSDictionary
                
                print("国家:\(dict["country"]) 地区：\(dict["Name"]) 位置：\(dict["Street"])")
                
                NSLog("_______________________________")
            }else{
                print("++++++++++++++++++++++++++++++")
            }
        }
    }

    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        print("定位代理方法：————————————————————————")
        print(self.delegate)
        var location = locations.first
        var coordinate:CLLocationCoordinate2D? = (location?.coordinate)! //坐标
        
        if coordinate != nil {
            NSLog("经度：%f,纬度：%f,海拔：%f,航向：%f,行走速度：%f",coordinate!.longitude,coordinate!.latitude,location!.altitude,location!.course,location!.speed)
            
            self.getAddressByLatitude(coordinate!.latitude, longitude: coordinate!.longitude)
            self.delegate!.passValueWithGeo(coordinate!.latitude, longitude: coordinate!.longitude)
          
            
        }
        
    }
  
    func startLocation(){
        self.clManager.startUpdatingLocation()
    }
    
    func stopLocation(){
        self.clManager.stopUpdatingLocation()
    }
}
