//
//  PuzzleGameViewController.swift
//  SolveThePuzzle
//
//  Created by Michael Hartanto on 4/6/17.
//  Copyright © 2017 Amritpal Singh. All rights reserved.
//

import UIKit
import Foundation

class PuzzleGameViewController: UIViewController {
    
    var seconds: Int = 0
    var minutes: Int = 0
    var timeIsOn = false
    var gameTimer: Timer!
    var time: Int = 0
    var pauseTime: String = ""
    
    @IBOutlet weak var pauseTimerButton: UIButton!
    @IBOutlet weak var startTimerButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBAction func playTimer(_ sender: AnyObject) {
        seconds = 0
        minutes = 0
        timerLabel.text = "0\(minutes):0\(seconds)"

        timeIsOn = true
    
        gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        
        if (timeIsOn == true){
            startTimerButton.isHidden = true;
        }
        
    }
    
    @IBAction func stopTimer(_ sender: AnyObject) {
        
        // When timer is off
        if (timeIsOn == false){
            
            // Show paused time
            timerLabel.text = pauseTime
            
            // Start timer/Resume timer again
            gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
            
            // Change Button Title
            pauseTimerButton.setTitle("Pause", for: .normal)

            // Timer state is on
            timeIsOn = true
            
        }
        
        // When timer is on
        else{

            // Stop Timer
            gameTimer.invalidate()
            
            // Save paused time
            pauseTime = timerLabel.text!
            
            // Change Button Title
            pauseTimerButton.setTitle("Resume", for: .normal)
            
            // Timer state is off
            timeIsOn = false
            
        }
        
    }
    
    func updateTime() {
        
        seconds = seconds + 1
        
        if (seconds <= 9){
            timerLabel.text = "0\(minutes):0\(seconds)"
        }
        
        if(seconds == 16){
            minutes = minutes + 1
            seconds = 0
            timerLabel.text = "0\(minutes):0\(seconds)"
        }
        
        if(minutes == 0){
            timerLabel.text = "0\(minutes):0\(seconds)"
            if(seconds >= 10){
                timerLabel.text = "0\(minutes):\(seconds)"}
        }
        
        // <=9
        if(minutes > 0 && minutes <= 9){
            timerLabel.text = "0\(minutes):0\(seconds)"
            if(seconds >= 10){
                timerLabel.text = "0\(minutes):\(seconds)"}
        }
        
        // >=10
        if(minutes >= 10){
            timerLabel.text = "\(minutes):0\(seconds)"
            
            if(seconds >= 10){
                timerLabel.text = "\(minutes):\(seconds)"
            }
        }
        
    }



    let allImgViews = NSMutableArray()
    let allCenters = NSMutableArray()

    
    override func viewDidLoad() {
    
        let allImgViews = NSMutableArray()
        let allCenters = NSMutableArray()
        
        var xCen: Int = 49;
        var yCen: Int = 200;
        
        super.viewDidLoad()
        
        for v in stride(from: 0, to: 4, by: 1)
        {
            for h in stride(from: 0, to: 4, by: 1)
            {
                var imageView : UIImageView
                imageView  = UIImageView(frame:CGRect(x:0, y:192, width:98, height:94));
                let currentCenter = CGPoint(x: xCen,y: yCen);
                allCenters.add(currentCenter)
                imageView.center = currentCenter;
                imageView.image = UIImage (named:String(format: "ai_%02i.jpg", h+v*4));
                imageView.isUserInteractionEnabled = true;
                allImgViews.add(imageView)
                view.addSubview(imageView)
                xCen += 98;
            }
            xCen = 49;
            yCen += 94;
        }
        allImgViews.removeObject(at: 0)
        self.randomizeBlocks()
 
 
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    var emptySlot = CGPoint();
    
     func randomizeBlocks() {
        var centersCopy = NSMutableArray()
        centersCopy = allCenters.mutableCopy() as! NSMutableArray
        var randLoc: Int = 0;
        for UIView in allImgViews
        {
            randLoc =  Int(arc4random()) % Int(centersCopy.count);
            randLoc = centersCopy.object(at: randLoc) as! Int
            //allImgViews = randLoc
            centersCopy.removeObject(at: randLoc)
        }
        emptySlot = centersCopy.object(at: 0) as! CGPoint

    }
    
    
    
    var tapCen = CGPoint();
    var left = CGPoint();
    var right = CGPoint();
    var top = CGPoint();
    var bottom = CGPoint();
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let myTouch = UITouch()
        if myTouch.view != self.view
        {
            tapCen = (myTouch.view?.center)!;
        }
    }
 
 
}

