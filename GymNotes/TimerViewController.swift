//
//  TimerViewController.swift
//  GymNotes
//
//  Created by Martin  on 16/06/16.
//  Copyright © 2016 Martin . All rights reserved.
//

import UIKit

class TimerViewController: UIViewController {
    
    var wodName: String?
    var timer : NSTimer?
    var startTime : NSTimeInterval?
    var accumulatedTime = NSTimeInterval()
    var startStopWatch: Bool = true
    
    @IBOutlet weak var previousTime: UILabel!
    @IBOutlet weak var currentTime: UILabel!
    @IBOutlet weak var reset: UIButton!
    @IBOutlet weak var startAndStop: UIButton!
    
    @IBAction func resetBtn(sender: AnyObject) {
        
        guard self.timer != nil else {
            return
        }
        
        /*
        let timeString = String(format:"%02d:%02d.%02d",00,00,00)
        currentTime.text = timeString
         */
        
        self.timer!.invalidate()
        self.timer = nil
        
        startStopWatch = true
        startAndStop.setTitle("Start", forState: UIControlState.Normal)
        startAndStop.backgroundColor = UIColor(hue: 0.4583, saturation: 0.7, brightness: 0.73, alpha: 1.0)
        
        
    }

    @IBAction func startBtn(sender: AnyObject) {
        
        if startStopWatch == true {
            
            
            self.startTime = NSDate.timeIntervalSinceReferenceDate()
            
            self.timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: #selector(TimerViewController.updateTime), userInfo: nil, repeats: true)
            
            startStopWatch = false
            startAndStop.setTitle("Stop", forState: UIControlState.Normal)
            startAndStop.backgroundColor = UIColor(hue: 0.9833, saturation: 0.68, brightness: 0.85, alpha: 1.0)
            
            
        } else {
            
 
            
            self.timer!.invalidate()
            self.timer = nil
        
            startStopWatch = true
            startAndStop.setTitle("Start", forState: UIControlState.Normal)
            startAndStop.backgroundColor = UIColor(hue: 0.4583, saturation: 0.7, brightness: 0.73, alpha: 1.0)
            
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateTime() {
        
        let currentTimeStamp = NSDate.timeIntervalSinceReferenceDate()
        let intervalTime = currentTimeStamp - startTime!
        self.startTime = currentTimeStamp
        self.accumulatedTime += intervalTime
        
        var elapsedTime = self.accumulatedTime
        
        
        let minutes = UInt8(elapsedTime / 60)
        elapsedTime -= (NSTimeInterval(minutes) * 60)
        
        let seconds = UInt8(elapsedTime)
        elapsedTime -= NSTimeInterval(seconds)
        
        let fraction = UInt8(elapsedTime * 100)
        
        let timeString = String(format:"%02d:%02d.%02d",minutes,seconds,fraction)
        currentTime.text = timeString
        
    }
    

}
