//
//  TodayView.swift
//  计步器
//
//  Created by 移动互联网协会2 on 16/3/14.
//  Copyright © 2016年 ccsu. All rights reserved.
//

import UIKit

class TodayView: UIView {

  
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func drawRect(rect: CGRect) {
    
        var context = UIGraphicsGetCurrentContext()
        
        CGContextAddEllipseInRect(context, rect)
        CGContextSetRGBFillColor(context, 1, 0, 0, 1)
        CGContextFillPath(context)
        
        
    }
}
