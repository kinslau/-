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
    
    
    var loca:CLLocationCoordinate2D?
    
    var minspeed:Double?
    var minFilter:Double?
    var minInterval:CGFloat?
    
    var delegate:PassValueLocationDelegate?
    var clManager:CLLocationManager!
 
    var geocoder:CLGeocoder!
    static let instance = Location()
    
    private  override  init() {
        super.init()
        
            self.minFilter = 1
            self.minInterval = 5
            self.minspeed = 3
        
            clManager = CLLocationManager()
          //  clManager.requestAlwaysAuthorization()
        
        
            clManager.desiredAccuracy = kCLLocationAccuracyBest
            clManager.distanceFilter = self.minFilter!  //1米定位以此
            geocoder = CLGeocoder()
            clManager.delegate = self
          
   
        
        
    }

 
    //反地理编码
    func getAddressByLatitude(latitude:CLLocationDegrees,longitude:CLLocationDegrees){
     
        var location = CLLocation(latitude: latitude, longitude: longitude)
        geocoder.reverseGeocodeLocation(location) { (placemarks, error)-> Void in
            
            if placemarks != nil{
                var placemark:CLPlacemark  = placemarks!.first!
                NSLog("_______________________________")
//                NSLog("详细信息:%@",placemark.addressDictionary!)
//                var dict:NSDictionary = placemark.addressDictionary as! NSDictionary
//                
//                print("国家:\(dict["country"]) 地区：\(dict["Name"]) 位置：\(dict["Street"])")
                
             
            }else{
                print("++++++++++++++++++++++++++++++")
            }
        }
    }

    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
      
        
        
       
        var location = locations.first
        
         NSLog("%@", location!)
  
        
        var coordinate:CLLocationCoordinate2D? = (location?.coordinate)! //坐标
        
        self.loca = coordinate
        
        
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
