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
    
    // Initialise Variables for Timer Features
    var seconds: Int = 0
    var minutes: Int = 0
    var timeIsOn = false
    var gameTimer: Timer!
    var time: Int = 0
    var pauseTime: String = ""
    
    // Initialise Variables for Puzzle Features
    var allImgViews = [UIView]()
    var allCenters = [Any]()
    var tagNumber = 0
    var gameCompleted = false

    // -- Blank Spot Variables -- //
    var emptySpot = CGPoint.zero
    var tapCen = CGPoint.zero
    var left = CGPoint.zero
    var right = CGPoint.zero
    var top = CGPoint.zero
    var bottom = CGPoint.zero
    
    // -- Box around blank spot Variables -- //
    var boxLeftCenter = CGPoint.zero
    var boxRightCenter  = CGPoint.zero
    var boxTopCenter  = CGPoint.zero
    var boxBottomCenter  = CGPoint.zero
    
    @IBOutlet weak var pauseResumeTimerButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var nameTxt: UITextField!
    
    @IBOutlet weak var startRestartGameButton: UIButton!
    
    override func viewDidLoad() {
    
        allImgViews = [UIView]()
        allCenters = [Any]()

        var xCen: Int = 49
        var yCen: Int = 200

        for v in 0..<4 {

            for h in 0..<4 {

                let myImgView = UIImageView(frame: CGRect(x: CGFloat(), y: CGFloat(192), width: CGFloat(98), height: CGFloat(94)))
                let curCen = CGPoint(x: CGFloat(xCen), y: CGFloat(yCen))
                allCenters.append(curCen)
                myImgView.center = curCen
                myImgView.tag = h + v * 4
                print(h, v, h+v*4)
                myImgView.image = UIImage(named: String(format: "ai_%02i.jpg", h + v * 4))
                myImgView.backgroundColor = UIColor.blue;
                myImgView.isUserInteractionEnabled = true
                allImgViews.append(myImgView)
                view.addSubview(myImgView)
                xCen += 98

            }

            xCen = 49
            yCen += 94

        }
        
        // Swiping Left
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(swipeLeft)

        // Swiping Right
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(swipeRight)
        
        // Swiping Up
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeUp.direction = UISwipeGestureRecognizerDirection.up
        self.view.addGestureRecognizer(swipeUp)
        
        // Swiping Down
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeDown.direction = UISwipeGestureRecognizerDirection.down
        self.view.addGestureRecognizer(swipeDown)
 
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let name : String? = UserDefaults.standard.object(forKey: "name") as? String
        
        if let nameToDisplay = name {
            statusLbl.text = nameToDisplay
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    //override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    //}
    
    
    @IBAction func savePressed(_ sender: AnyObject) {
        statusLbl.text = nameTxt.text
        UserDefaults.standard.set(nameTxt.text, forKey: "name")
        UserDefaults.standard.set(timerLabel.text, forKey: "time")
    }
    

    // Function to randomise the block
    func randomizeBlocks() {

        // removing the last image view
        allImgViews[15].removeFromSuperview()
        allImgViews.remove(at: 15)
        
        var centersCopy: [Any] = allCenters
        var randLocInt: Int
        var randLoc: CGPoint

        for view in allImgViews {

            randLocInt = Int(arc4random_uniform(UInt32(centersCopy.count))) //% centersCopy.count
            print("available location", centersCopy)
            randLoc = centersCopy[randLocInt] as! CGPoint
            print("chosen index", randLocInt, "which is", randLoc)
            view.center = randLoc
            centersCopy.remove(at: randLocInt) // remove what is used

        }

        emptySpot = centersCopy[0] as! CGPoint
        print("remaining that doesnt get chosen",emptySpot)

    }
    
    // Function to return the center coordinate of the left side of the blank spot
    func findSurroundingLeftBox(box: CGPoint) -> CGPoint{
        
        var boxLeft = CGPoint.zero
        boxLeft.x = emptySpot.x - 98
        boxLeft.y = emptySpot.y
        return boxLeft
        
    }
    
    // Function to return the center coordinate of the right side of the blank spot
    func findSurroundingRightBox(box: CGPoint) -> CGPoint{
        
        var boxRight = CGPoint.zero
        boxRight.x = emptySpot.x + 98
        boxRight.y = emptySpot.y
        return boxRight
        
    }
    
    // Function to return the center coordinate of the top side of the blank spot
    func findSurroundingTopBox(box: CGPoint) -> CGPoint{
        
        var boxTop = CGPoint.zero
        boxTop.x = emptySpot.x
        boxTop.y = emptySpot.y - 94
        return boxTop
        
    }
    
    // Function to return the center coordinate of the bottom side of the blank spot
    func findSurroundingBottomBox(box: CGPoint) -> CGPoint{
        
        var boxBottom = CGPoint.zero
        boxBottom.x = emptySpot.x
        boxBottom.y = emptySpot.y + 94
        return boxBottom
        
    }
    
    func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
                
            case UISwipeGestureRecognizerDirection.left:
                print("Swiped left")
                print("empty box",emptySpot)
                
                boxRightCenter = findSurroundingRightBox(box: emptySpot)
                print("box left coordinate", findSurroundingLeftBox(box: emptySpot) ,"\n","box right coordinate", findSurroundingRightBox(box: emptySpot) ,"\n","box top coordinate", findSurroundingTopBox(box: emptySpot) ,"\n","box bottom coordinate", findSurroundingBottomBox(box: emptySpot))
                
                if(boxRightCenter.x < 344){
                    for view in allImgViews{
                        
                        if (view.center == (boxRightCenter)){
                            view.center.x = emptySpot.x
                            emptySpot = boxRightCenter
                            print("new empty spot", emptySpot)
                            print("box left coordinate", findSurroundingLeftBox(box: emptySpot) ,"\n","box right coordinate", findSurroundingRightBox(box: emptySpot),"\n","box top coordinate",findSurroundingTopBox(box: emptySpot),"\n","box bottom coordinate",findSurroundingBottomBox(box: emptySpot))
                        }
                    }
                }
                else{
                    print("unable to move")
                }
                
            case UISwipeGestureRecognizerDirection.right:
                
                print("Swiped right")
                print("empty box",emptySpot)
                
                boxLeftCenter = findSurroundingLeftBox(box: emptySpot)
                print("box left coordinate", findSurroundingLeftBox(box: emptySpot) ,"\n","box right coordinate", findSurroundingRightBox(box: emptySpot) ,"\n","box top coordinate", findSurroundingTopBox(box: emptySpot) ,"\n","box bottom coordinate", findSurroundingBottomBox(box: emptySpot))
                
                if(boxLeftCenter.x > 48){
                    for view in allImgViews{
                        
                        if (view.center == (boxLeftCenter)){
                            view.center.x = emptySpot.x
                            emptySpot = boxLeftCenter
                            print("new empty spot", emptySpot)
                            print("box left coordinate", findSurroundingLeftBox(box: emptySpot) ,"\n","box right coordinate", findSurroundingRightBox(box: emptySpot) ,"\n","box top coordinate", findSurroundingTopBox(box: emptySpot) ,"\n","box bottom coordinate", findSurroundingBottomBox(box: emptySpot))
                        }
                    }
                }
                else{
                    print("unable to move")
                }
                
            case UISwipeGestureRecognizerDirection.up:
                
                print("Swiped up")
                print("empty box",emptySpot)
                
                boxBottomCenter  = findSurroundingBottomBox(box: emptySpot)
                print("box left coordinate", boxLeftCenter , "\n","box right coordinate", boxRightCenter , "\n","box top coordinate", boxTopCenter , "\n","box bottom coordinate", boxBottomCenter )
                
                if(boxBottomCenter.y < 483){
                    for view in allImgViews{
                        
                        if (view.center == (boxBottomCenter)){
                            view.center.y = emptySpot.y
                            emptySpot = boxBottomCenter
                            print("new empty spot", emptySpot)
                            print("box left coordinate", findSurroundingLeftBox(box: emptySpot) ,"\n","box right coordinate", findSurroundingRightBox(box: emptySpot),"\n","box top coordinate",findSurroundingTopBox(box: emptySpot),"\n","box bottom coordinate",findSurroundingBottomBox(box: emptySpot))
                        }
                    }
                }
                else{
                    print("unable to move")
                }
                
            case UISwipeGestureRecognizerDirection.down:
                
                print("Swiped down")
                print("empty box",emptySpot)
                
                boxTopCenter  = findSurroundingTopBox(box: emptySpot)
                print("box left coordinate", boxLeftCenter , "\n","box right coordinate", boxRightCenter , "\n","box top coordinate", boxTopCenter , "\n","box bottom coordinate", boxBottomCenter )
                
                if(boxTopCenter.y > 199){
                    for view in allImgViews{
                        
                        if (view.center == (boxTopCenter)){
                            view.center.y = emptySpot.y
                            emptySpot = boxTopCenter
                            print("new empty spot", emptySpot)
                            print("box left coordinate", findSurroundingLeftBox(box: emptySpot) ,"\n","box right coordinate", findSurroundingRightBox(box: emptySpot),"\n","box top coordinate",findSurroundingTopBox(box: emptySpot),"\n","box bottom coordinate",findSurroundingBottomBox(box: emptySpot))
                        }
                    }
                }
                else{
                    print("unable to move")
                }
                
            default:
                break
            }
        }
        
        gameCompleted = checkingWinCondition()
        if(gameCompleted == true){
            stopTimer()
            startRestartGameButton.setTitle("Reshuffle Puzzle", for: .normal)
            startRestartGameButton.isHidden = false
            gameCompleted = false
            timeIsOn = false
            
            
            /*
 
 
 
                        Save Time Here
             
             
 
            */
        }
    }

    // Function to start the game
    @IBAction func startGame(_ sender: AnyObject) {
        
        randomizeBlocks()
        startTimer()
        
    }
    
    @IBAction func pauseResumeTimer(_ sender: AnyObject) {
        
        // Resume only when timer is off
        if (timeIsOn == false){
            
            resumeTimer()

            // Timer state is on
            timeIsOn = true
            
        }
        
        // Pause only when timer is on
        else{

            stopTimer()
            
            // Timer state is off
            timeIsOn = false
            
        }
        
    }
    
    // Function to update the time
    func updateTime() {
        
        // Increase seconds
        seconds = seconds + 1
        
        // When timer reach 9 seconds,
        // Set label format to 0x:0x
        if (seconds <= 9){
            timerLabel.text = "0\(minutes):0\(seconds)"
        }
        
        // Once seconds reach 60
        // Increase minutes and set seconds to 0
        // Set label format to 0x:0x
        if(seconds == 60){
            minutes = minutes + 1
            seconds = 0
            timerLabel.text = "0\(minutes):0\(seconds)"
        }
        
        // When minutes is 0
        // Set label format to 0x:0x
        // Except if seconds exceeds 10, set label format to 0x:xx
        if(minutes == 0){
            timerLabel.text = "0\(minutes):0\(seconds)"
            if(seconds >= 10){
                timerLabel.text = "0\(minutes):\(seconds)"}
        }
        
        // When minutes is around 1 and 9
        // Set label format to 0x:0x
        // Except if seconds exceeds 10, set label format to 0x:xx
        if(minutes > 0 && minutes <= 9){
            timerLabel.text = "0\(minutes):0\(seconds)"
            if(seconds >= 10){
                timerLabel.text = "0\(minutes):\(seconds)"}
        }
        
        // When minutes exceeds 10
        // Set label format to xx:0x
        // Except if seconds exceeds 10, set label format to Xx:xx
        if(minutes >= 10){
            timerLabel.text = "\(minutes):0\(seconds)"
            
            if(seconds >= 10){
                timerLabel.text = "\(minutes):\(seconds)"
            }
        }
        
    }

    func startTimer(){

        // Start the timer from 00:00
        seconds = 0
        minutes = 0
        timeIsOn = true
        
        timerLabel.text = "0\(minutes):0\(seconds)"

        // Call the updateTime function every 1 second
        gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        
        // When timer is on
        if (timeIsOn == true){
            
            // Hide the start button
            startRestartGameButton.isHidden = true;
        }

    }
    
    func restartTimer(){
        
        
        
    }
    
    func resumeTimer(){
        
        // Show paused time
        timerLabel.text = pauseTime
        
        // Start timer/Resume timer again
        gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        
        // Change Button Title
        pauseResumeTimerButton.setTitle("Pause", for: .normal)
        
    //let allImgViews = NSMutableArray()
    //let allCenters = NSMutableArray()

    
    func viewDidLoad() {
    
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
        }}
        //allImgViews.removeObject(at: 0)
        self.randomizeBlocks()
 

    }
    
    func stopTimer(){
        
        // Stop Timer
        gameTimer.invalidate()
        
        // Save paused time
        pauseTime = timerLabel.text!
        
        // Change Button Title
        pauseResumeTimerButton.setTitle("Resume", for: .normal)
                
    }
    
   func checkingWinCondition() -> Bool{
        var xCen: Int = 49
        var yCen: Int = 200
        
        var positionCondition = ["false","false","false","false","false","false","false","false","false","false","false","false","false","false","false"]
        var i = 0
        
        // Set true or false condition
        for _ in 0..<positionCondition.count{
            
            if(allImgViews[i].tag == (i) && allImgViews[i].center == CGPoint(x:xCen,y:yCen)){
                positionCondition[i] = "true"
                print("position true","all imgviews[]",i,"(",xCen,yCen,")",positionCondition[i])
                
            }else{
                positionCondition[i] = "false"
                print("position false","all imgviews[]",i,"is not in (",xCen,yCen,")",positionCondition[i])
            }
            
            i = i + 1
            xCen += 98
            
            if(i == 4 || i == 8 || i == 12){
                xCen = 49
                yCen += 94
                
            }
            
        }
        
        // check condition
        // if all condition is true, game is completed
        // if one of the condition is false, game is not completed
        var z = 0
        for condition in positionCondition{
            if(condition == "true"){
                gameCompleted = true
            }
            else{
                gameCompleted = false
                break
            }
            print("condition",[z],gameCompleted,positionCondition.count)

            z=z+1
        }
        
        print("Game Completed",gameCompleted)
        return gameCompleted

    }
    
    @IBAction func goToVC(_ sender: AnyObject) {
        let userInput = timerLabel.text
        performSegue(withIdentifier: "goToVC", sender: userInput)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToVC"
        {
            if let destination = segue.destination as? ViewController
            {
                destination.passedData = sender as? String
                print ("Sender Value: \(sender)")
            }
        }
    }
}

