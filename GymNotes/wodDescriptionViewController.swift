//
//  wodDescriptionViewController.swift
//  GymNotes
//
//  Created by Martin  on 21/06/16.
//  Copyright © 2016 Martin . All rights reserved.
//

import UIKit

class wodDescriptionViewController: UIViewController{
    
    
    var wodName: String?
    var wodType: String?
    var exerciseOne: String?
    var exerciseTwo: String?
    var exerciseThree: String?
    var exerciseFour: String?
    var color: String?
    
    @IBOutlet weak var backgroundColor: UIView!
    
    @IBOutlet weak var wodNameLabel: UILabel!
    
    @IBOutlet weak var wodTypeLabel: UILabel!
    
    @IBOutlet weak var exerciseOneLabel: UILabel!
    
    @IBOutlet weak var exerciseTwoLabel: UILabel!
    
    @IBOutlet weak var exerciseThreeLabel: UILabel!
    
    @IBOutlet weak var exerciseFourLabel: UILabel!

    @IBOutlet weak var backBtn: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
            
        /*
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.translucent = true
 */
        
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        wodNameLabel.text = wodName
        wodTypeLabel.text = wodType
        exerciseOneLabel.text = exerciseOne
        exerciseTwoLabel.text = exerciseTwo
        exerciseThreeLabel.text = exerciseThree
        exerciseFourLabel.text = exerciseFour
        
        if color == "Green" {
            backgroundColor.backgroundColor = UIColor(hue: 0.4583, saturation: 0.7, brightness: 0.73, alpha: 1.0)
        } else if color == "Blue" {
            backgroundColor.backgroundColor  = UIColor(hue: 0.5444, saturation: 0.72, brightness: 0.85, alpha: 1.0)
        } else if color == "Orange" {
            backgroundColor.backgroundColor  = UIColor(hue: 0.0222, saturation: 0.72, brightness: 0.91, alpha: 1.0)
        } else if color == "Red" {
            backgroundColor.backgroundColor  =  UIColor(hue: 0.9833, saturation: 0.68, brightness: 0.85, alpha: 1.0)
        }


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showStopwatch"
        {
            
            let vc = segue.destinationViewController as! TimerViewController
            
            vc.title = wodName
            vc.wodName = wodName
            
        }
    }

}
