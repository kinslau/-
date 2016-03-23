//
//  Weather.swift
//  Sulo
//
//  Created by 移动互联网协会2 on 16/3/22.
//  Copyright © 2016年 ccsu. All rights reserved.
//

import UIKit


@objc protocol WeatherDelegate{
    optional func currenWeather(city:String,tem:String,weather:String)

}

class Weather: NSObject {
    
    
    var delegate:WeatherDelegate?
    
    var url = "http://apis.baidu.com/apistore/weatherservice/weather"
    var httpArg = "citypinyin=changsha"
    
    override init() {
        super.init()
        
        self.request(url, httpArg: httpArg)
        
    }
    
    
    func  request(httpUrl: String, httpArg: String) {
        var req = NSMutableURLRequest(URL: NSURL(string: httpUrl + "?" + httpArg)!)
        req.timeoutInterval = 6
        req.HTTPMethod = "GET"
        req.addValue("您自己的apikey", forHTTPHeaderField: "apikey")
        NSURLConnection.sendAsynchronousRequest(req, queue: NSOperationQueue.mainQueue()) {
            (response, data, error) -> Void in
            let res = response as! NSHTTPURLResponse
            print(res.statusCode)
            if let e = error{
                print("请求失败")
            }
            if let d = data {
                var content = NSString(data: d, encoding: NSUTF8StringEncoding)
                
                //print(content)
                
                
                do{
                     var dic:NSDictionary = try NSJSONSerialization.JSONObjectWithData(d, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
                    
                    
//                    
//                    print(dic)
//                    print(dic["retData"]?.objectForKey("city"))
//                    print(dic["retData"]?.objectForKey("weather"))
//                    print(dic["retData"]?.objectForKey("temp"))
                    var city = dic["retData"]?.objectForKey("city") as! String
                    var weather = dic["retData"]?.objectForKey("weather") as! String
                    var temp = dic["retData"]?.objectForKey("temp") as! String
//                    
//                    print(city)
//                    print(weather)
//                    print(temp)
                
                    
                    self.delegate?.currenWeather!(city, tem: temp, weather: weather)
                    
                    

                }catch{
                    print("解析失败")
                }
                
                
         
            }
        }
    }
    
    
}
