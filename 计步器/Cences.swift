//
//  Cences.swift
//  计步器
//
//  Created by 移动互联网协会2 on 16/3/17.
//  Copyright © 2016年 ccsu. All rights reserved.
//

import UIKit
import CoreLocation
//数据统计

class Cences: NSObject {
    
    var loca:CLLocationCoordinate2D? //地点
    var distance:Int? // 运动距离
    var time:NSDate? //日期
    var interval:NSTimeInterval? //时间
    var tag:String? //标识
    
    
    override init() {
        super.init()
    }
    
    
    init(location:CLLocationCoordinate2D,distance:Int,time:NSDate,interval:NSDate) {
 
        
    }
    
    
}
