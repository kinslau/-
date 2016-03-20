//
//  MusicVC.swift
//  计步器
//
//  Created by 移动互联网协会2 on 16/3/17.
//  Copyright © 2016年 ccsu. All rights reserved.
//

import UIKit
import AVFoundation

@objc protocol MusicPlayDelegate{
    optional  func ControlPlay(play:Bool)
    optional func stop()
    
    
}

class Music: NSObject,AVAudioPlayerDelegate,MusicPlayDelegate {

   
    var delegate:MusicPlayDelegate?
    var audioPlayer:AVAudioPlayer?
    var musicView:UIView?
    
    
    
    override init() {
        super.init()

        self.setAudioPlayer()
        musicView?.layer.cornerRadius = 10
        musicView?.backgroundColor = UIColor.magentaColor()
        self.delegate = self
        
        print(self)
    }

    func ControlPlay(play: Bool) {
     
        if play{
            self.play()
        }else{
            pause()
        }
        
    }
    
    
    func setAudioPlayer(){
        do{
             audioPlayer = try AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("Little Numbers.mp3", ofType: nil)!))
            audioPlayer?.delegate = self
            audioPlayer?.numberOfLoops = Int.max
            audioPlayer?.prepareToPlay()
            
        }catch{

        }
        
    }
    

    
    func play(){
        if self.audioPlayer?.playing == true{
            
        }else{
            self.audioPlayer?.play()
        }
        
    }
    
    func stop(){
        if self.audioPlayer?.playing == true{
            self.audioPlayer?.stop()
        }
       self.audioPlayer?.stop()
    }
    func pause(){
        if self.audioPlayer?.playing == true{
             self.audioPlayer?.pause()
        }
       
    }
    

    
    

}
