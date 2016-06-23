//
//  WodsViewController.swift
//  GymNotes
//
//  Created by Martin  on 16/06/16.
//  Copyright © 2016 Martin . All rights reserved.
//

import UIKit

class WodsViewController: UICollectionViewController  {
    
    let wodNames = ["Amanda","Angie","Annie","Barbara","Chelsea","Christine","Cindy","Diane","Elizabeth","Eva","Fran","Grace","Helen","Isabel","Jackie","Karen","Kelly","Linda","Lynne","Mary","Nancy","Nicole"]
    
    let wodStyle = ["9-7-5","For Time","50-40-30-20-10","5 rounds for time","EMOM for 30 min","3 rounds","AMRAP in 20 min","21-15-9","21-15-9 ","5 rounds","21-15-9","For Time","3 rounds","For Time","For Time","For Time","5 rounds","10/9/8/7/6/5/4/3/2/1 ","5 rounds","AMRAP in 20 min","5 rounds","AMRAP in 20 min"]
    
    let exOne = ["Muscle Up","100 Pull-ups","Double-unders","20 Pull-ups","5 Pull-ups","500m row ","5 Pull-ups","Deadlift","Clean","800m run","Thruster","30 Clean and Jerks","400m run","30 Snatch","1000m row","150 Wall balls","400m run","Deadlift","Max reps Bench","5 HSPU","400m run","400m run"]
    
    let exTwo = ["Squat Snatch","100 Push-ups","Sit-ups","30 Push-ups","10 Push-ups","12 Deadlift","10 Push-ups","HSPU","Ring Dips","30 kettlebell swings","Pull-ups","","21 Kettlebell Swings","","50 Thrusters","","30 box jump","Bench","Max reps Pull-ups","10 single leg squats","15 Overhead squat","Max rep Pull-ups"]
    
    let exThree = ["","100 Sit-ups","","40 Sit-ups","15 Air Squats","21 Box Jumps","15 Air Squats","","","30 pullups","","","12 Pull-ups","","30 Pull-ups","","30 Wall ball shots","Clean","","15 Pull-ups","",""]
    
    let exFour = ["","100 Air Squats","","50 Air Squats","","","","","","","","","","","","","","","","","",""]
    
    let collectionColor = ["Green","Green","Green","Red","Red","Red","Red","Red","Red","Red","Orange","Orange","Orange","Orange","Orange","Blue","Blue","Blue","Blue","Blue","Blue","Blue"]

    
    let wodStyleFullDescription = ["9-7-5","For Time","50-40-30-20-10","5 rounds for time","Every minute, on the minute for 30 min","3 rounds","AMRAP in 20 min","21-15-9","21-15-9 ","5 rounds","21-15-9","For Time","3 rounds","For Time","For Time","For Time","5 rounds","10/9/8/7/6/5/4/3/2/1 ","5 rounds","AMRAP in 20 min","5 rounds","AMRAP in 20 min"]
    
    
    let exOneDescription = ["Muscle Up","100 Pull-ups","Double-unders","20 Pull-ups","5 Pull-ups","500m row ","5 Pull-ups","Deadlift (225#)","Clean (135#)","800m run","Thruster (95#)","30 Clean and Jerks (135#)","400m run","30 Snatch","1000m row","150 Wall balls","400m run","Deadlift (1 1/2 BW)","Max reps Bench (BW)","5 Handstand push-ups","400m run","400m run"]
    
    let exTwoDescription = ["Squat Snatch (135# / 95#)","100 Push-ups","Sit-ups","30 Push-ups","10 Push-ups","12 Deadlift (BW)","10 Push-ups","Handstand push-ups","Ring Dips","30 kettlebell swings","Pull-ups","","21 Kettlebell Swings","","50 Thrusters (45#)","","30 box jump, 24 inch box","Bench (BW)","Max reps Pull-ups","10 single leg squats","15 Overhead squat (95#)","Max rep Pull-ups"]
    
    let exThreeDescription = ["","100 Sit-ups","","40 Sit-ups","15 Air Squats","21 Box Jumps","15 Air Squats","","","30 pullups","","","12 Pull-ups","","30 Pull-ups","","30 Wall ball shots","Clean (3/4 BW)","","15 Pull-ups","",""]
    
    let exFourDescription = ["","100 Air Squats","","50 Air Squats","","","","","","","","","","","","","","","","","",""]
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.wodNames.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! WodCollectionViewCell
        
        cell.wodName.text = self.wodNames[indexPath.row]
        cell.wodType.text = self.wodStyle[indexPath.row]
        cell.exerciseOne.text = self.exOne[indexPath.row]
        cell.exerciseTwo.text = self.exTwo[indexPath.row]
        cell.exerciseThree.text = self.exThree[indexPath.row]
        cell.exerciseFour.text = self.exFour[indexPath.row]
        
        if collectionColor[indexPath.row] == "Green" {
            cell.backgroundColor = UIColor(hue: 0.4583, saturation: 0.7, brightness: 0.73, alpha: 1.0)
        } else if collectionColor[indexPath.row] == "Blue" {
            cell.backgroundColor = UIColor(hue: 0.5444, saturation: 0.72, brightness: 0.85, alpha: 1.0)
        } else if collectionColor[indexPath.row] == "Orange" {
            cell.backgroundColor = UIColor(hue: 0.0222, saturation: 0.72, brightness: 0.91, alpha: 1.0)
        } else if collectionColor[indexPath.row] == "Red" {
            cell.backgroundColor =  UIColor(hue: 0.9833, saturation: 0.68, brightness: 0.85, alpha: 1.0)
        }
        
        return cell
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showWod"
        {
            
            let indexPaths = self.collectionView!.indexPathsForSelectedItems()!
            let indexPath = indexPaths[0] as NSIndexPath
            
            let vc = segue.destinationViewController as! wodDescriptionViewController
            
            vc.wodName = wodNames[indexPath.row]
            vc.wodType = wodStyleFullDescription[indexPath.row]
            vc.exerciseOne = exOneDescription[indexPath.row]
            vc.exerciseTwo = exTwoDescription[indexPath.row]
            vc.exerciseThree = exThreeDescription[indexPath.row]
            vc.exerciseFour = exFourDescription[indexPath.row]
            vc.color = collectionColor[indexPath.row]
            
        }
    }

}
