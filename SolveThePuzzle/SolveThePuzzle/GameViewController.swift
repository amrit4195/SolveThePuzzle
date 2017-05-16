//
//  GameViewController.swift
//  SolveThePuzzle
//
//  Created by Michael Hartanto on 5/13/17.
//  Copyright © 2017 Amritpal Singh. All rights reserved.
//

import UIKit
import CoreData
import AVFoundation

class GameViewController: UIViewController {
    
    var buttonPressedSFX: AVAudioPlayer?
    var puzzleSlideSFX: AVAudioPlayer?
    var applauseSFX: AVAudioPlayer?

    var pictureName = ""
    var puzzlePiecesFormat = ""
    var puzzlePicture:UIImage!

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
    
    // Recording High score Variables
    var highScore = 20000
    var userScore = 0
    var username = ""
    
    // Gesture Variables
    var swipeLeft: UISwipeGestureRecognizer!
    var swipeRight: UISwipeGestureRecognizer!
    var swipeUp: UISwipeGestureRecognizer!
    var swipeDown: UISwipeGestureRecognizer!
    
    // Puzzle Image Variable
    var puzzleImg: UIImageView!
    
    var retrievedName : String!
    var retrievedHighScore : Int!
    var retrievedTime : String!
    
    var savedBestUser : String! = "BestUser"
    var savedBestTime : String! = "BestTime"
    var savedHighscore : String! = "Highscore"
    
    var soundIsOn = true
    
    @IBOutlet weak var pausePuzzleImageView: UIImageView!
    @IBOutlet weak var pausePopupView: UIView!
    @IBOutlet weak var backgroundButton: UIButton!
    @IBOutlet weak var centerXPausePopupConstraint: NSLayoutConstraint!
    @IBOutlet weak var pauseGameButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var savedHighScoreLabel: UILabel!
    @IBOutlet weak var startGameButton: UIButton!
    @IBOutlet weak var savedUsernameLabel: UILabel!
    @IBOutlet weak var closePausePopupViewButton: UIButton!
    @IBOutlet weak var restartGameButton: UIButton!
    @IBOutlet weak var bottomGameContainer: UIView!
    
    @IBOutlet weak var yBottomContainer: NSLayoutConstraint!
    
    
    // As the view load
    // - Set Default image to the image view that will be put inside the pause popup view
    // - Hide Pause popupview
    // - Set up the pause popup view design
    // - Reset the Timer
    // - Create the template for the puzzle
    // - Create different swipe gesture
    override func viewDidLoad() {
        
        let buttonPressedSFXPath = Bundle.main.path(forResource: "buttonSFX", ofType: "wav")
        let buttonPressedSFXURL = NSURL.fileURL(withPath: buttonPressedSFXPath!)
        
        let puzzleSlideSFXPath = Bundle.main.path(forResource: "puzzle-slide", ofType: "mp3")
        let puzzleSlideSFXURL = NSURL.fileURL(withPath: puzzleSlideSFXPath!)
        
        let applauseSFXPath = Bundle.main.path(forResource: "applause", ofType: "wav")
        let applauseSFXURL = NSURL.fileURL(withPath: applauseSFXPath!)
        
        do{
            try buttonPressedSFX = AVAudioPlayer(contentsOf: buttonPressedSFXURL)
            
            buttonPressedSFX?.prepareToPlay()
        }
        catch{print("Player does not work for some reason")}
        
        do{
            try puzzleSlideSFX = AVAudioPlayer(contentsOf:puzzleSlideSFXURL)
            
            puzzleSlideSFX?.prepareToPlay()
            
        }
        catch{print("Player does not work for some reason")}
        
        do{
            try applauseSFX = AVAudioPlayer(contentsOf: applauseSFXURL)
            
            applauseSFX?.prepareToPlay()
            
            
        }
        catch{print("Applause SFX does not work for some reason")}

        if(soundIsOn == true){
            buttonPressedSFX?.volume = 5
            applauseSFX?.volume = 5
            puzzleSlideSFX?.volume = 5

        }
        else{
            buttonPressedSFX?.volume = 0
            applauseSFX?.volume = 0
            puzzleSlideSFX?.volume = 0
        }
        
        print("dasdasda", pictureName)
        print("feirfjerfre", savedBestUser, savedBestTime, savedHighscore)

        puzzlePicture = UIImage(named: pictureName)
        pausePuzzleImageView.image = puzzlePicture
        pausePopupView.alpha = 0
        pausePopupView.layer.cornerRadius = 20
        pausePopupView.layer.masksToBounds = true
        
        resetTimer()
        createPuzzleTemplate(picture: puzzlePicture)
        
        // Swiping Left
        swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(swipeLeft)
        
        // Swiping Right
        swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(swipeRight)
        
        // Swiping Up
        swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeUp.direction = UISwipeGestureRecognizerDirection.up
        self.view.addGestureRecognizer(swipeUp)
        
        // Swiping Down
        swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeDown.direction = UISwipeGestureRecognizerDirection.down
        self.view.addGestureRecognizer(swipeDown)
        
    }
    
    // As the view appear
    // Show the current highscore and the name of the holder
    override func viewDidAppear(_ animated: Bool) {
        
        updateHighScoreRecord()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /* ===================== Function for time ========================*/
    /* Contain startTimer() - A function to start the timer */
    /* Contain stopTimer() - A function to stop the timer */
    /* Contain resumeTimer() - A function to resume the timer when it was previously stopped */
    /* Contain resetTimer() - A function to reset the timer to 00:00 */
    /* Contain updateTime() - A function to increment the timer (seconds and minutes) */
    
    // Start Timer Function
    // - Set the time state to true
    // - Create a scheduled timer to run the updateTime function for every 1 second
    // - Hide the start game button
    func startTimer(){
        
        if(timeIsOn == false){
            timeIsOn = true
            gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        }
        
    }
    
    // Stop Timer Function
    // - Set the time state to false
    // - Stop the game timer
    // - Keep the current timer from the timerLabel.text
    func stopTimer(){
        
        if(timeIsOn == true){
            timeIsOn = false
            gameTimer.invalidate()
            pauseTime = timerLabel.text!
        }
    
    }
    
    // Resume Timer Function
    // - Set the time state to true
    // - Start the game timer again
    func resumeTimer(){
        
        if(timeIsOn == false){
            timeIsOn = true
            timerLabel.text = pauseTime
            gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        }
        
        
    }
    
    // Reset Timer Function
    // - Set the time state to false
    // - Set seconds and minutes to 0
    // - Start the timer from 00:00
    // - Update the timerLabel
    func resetTimer(){
        
        timeIsOn = false
        seconds = 0
        minutes = 0
        timerLabel.text = "0\(minutes):0\(seconds)"
        
    }
    
    // Function to update the time
    // - Increase seconds
    //
    // - When timer reach 9 seconds
    // --- Set label format to 0x:0x
    //
    // - Once seconds reach 60
    // --- Increase minutes and set seconds to 0
    // --- Set label format to 0x:0x
    //
    // - When minutes is 0
    // --- Set label format to 0x:0x
    // --- Except if seconds exceeds 10, set label format to 0x:xx
    //
    // - When minutes is around 1 and 9
    // --- Set label format to 0x:0x
    // --- Except if seconds exceeds 10, set label format to 0x:xx
    //
    // - When minutes exceeds 10
    // --- Set label format to xx:0x
    // --- Except if seconds exceeds 10, set label format to xx:xx
    func updateTime() {
        
        seconds = seconds + 1
        
        if (seconds <= 9){
            timerLabel.text = "0\(minutes):0\(seconds)"
        }
        
        if(seconds == 60){
            minutes = minutes + 1
            seconds = 0
            timerLabel.text = "0\(minutes):0\(seconds)"
        }
        
        if(minutes == 0){
            timerLabel.text = "0\(minutes):0\(seconds)"
            if(seconds >= 10){
                timerLabel.text = "0\(minutes):\(seconds)"}
        }
        
        if(minutes > 0 && minutes <= 9){
            timerLabel.text = "0\(minutes):0\(seconds)"
            if(seconds >= 10){
                timerLabel.text = "0\(minutes):\(seconds)"}
        }
        
        if(minutes >= 10){
            timerLabel.text = "\(minutes):0\(seconds)"
            
            if(seconds >= 10){
                timerLabel.text = "\(minutes):\(seconds)"
            }
        }
        
    }
    
    /* ===================== Function Related to the Puzzle Game ========================*/
    /* Contain createPuzzleTemplate() - Creating a dark template for the puzzle */
    /* Contain createPuzzle() - Creating the puzzle pieces */
    /* Contain destroyPuzzle() - Destroyng or deleting the puzzle pieces */
    /* Contain freezePuzzle() - Freezing the puzzle / disable swipe gesture */
    /* Contain unFreezePuzzle() - Unfreezing the puzzle / enable swipe gesture  */
    /* Contain checkingWinCondition() - Check whether the game is completed or not */
    /* Contain randomizeBlocks() - Randomize the location of the puzzle */
    /* Contain findSurroundingLeftBox(box: CGPoint) -> CGPoint - Find the left box location from the empty spot */
    /* Contain findSurroundingRightBox(box: CGPoint) -> CGPoint - Find the right box location from the empty spot */
    /* Contain findSurroundingTopBox(box: CGPoint) -> CGPoint - Find the top box location from the empty spot */
    /* Contain findSurroundingBottomBox(box: CGPoint) -> CGPoint - Find the bottom box location from the empty spot */
    /* Contain respondToSwipeGesture(gesture: UIGestureRecognizer) - Responding to different swipe gesture/direction */
    /* Contain updateHighScoreRecord() - Updating the user's highscore and name */
    
    // Creating template for the puzzle
    // - Show user the dark original photo of the puzzle for hints
    //
    // - Create a dark view box using the boxWidth, boxHeight, xCen and yCen variable
    // - Set the dark box center
    // - add darkBox to the view's subview
    //
    // - Create the puzzle image view using the darkBoxWidth, darkBoxHeight, xCen and yCen variable
    // - Set the puzzle image to the image view
    // - Set the center
    // - Fade the puzzle image color by playing with the alpha
    // - add puzzle image view to the view's subview
    //
    func createPuzzleTemplate(picture: UIImage){
        
        let boxWidth: Int = 98
        let boxHeight: Int = 94
        let xCen: Int = 49
        let yCen: Int = 200
        let darkBoxWidth: Int = boxWidth * 4
        let darkBoxHeight: Int = boxHeight * 4
        
        let darkBox = UIView(frame: CGRect(x: CGFloat(xCen), y: CGFloat(yCen), width: CGFloat(darkBoxWidth), height: CGFloat(darkBoxHeight)))
        let darkBoxCen = CGPoint(x: CGFloat(darkBoxWidth / 2), y: CGFloat(yCen + boxHeight + (boxHeight/2)))
        darkBox.center = darkBoxCen
        darkBox.backgroundColor = UIColor.black
        view.addSubview(darkBox)
        
        puzzleImg = UIImageView(frame: CGRect(x: CGFloat(xCen), y: CGFloat(yCen), width: CGFloat(darkBoxWidth), height: CGFloat(darkBoxHeight)))
        puzzleImg.image = picture
        let puzzleImgCen = CGPoint(x: CGFloat(darkBoxWidth / 2), y: CGFloat(yCen + boxHeight + (boxHeight/2)))
        puzzleImg.center = puzzleImgCen
        puzzleImg.alpha = 0.3
        view.addSubview(puzzleImg)
        
    }
    
    //
    // -- Removing the last photo array
    
    // Creating the puzzle
    // - Create an array of small UIImageView using the boxWidth, boxHeight, xCen and yCen variable
    // - Set different center for the UIImageView
    // - Store each center on an array
    // - Set different picture for the UIImageView using the string format and set user interaction to be true
    // - Add each puzzle to the view
    func createPuzzle(){
        
        allImgViews = [UIView]()
        allCenters = [Any]()
        
        let boxWidth: Int = 98
        let boxHeight: Int = 94
        
        var xCen: Int = 49
        var yCen: Int = 200
        
        for v in 0..<4 {
            
            for h in 0..<4 {
                
                let myImgView = UIImageView(frame: CGRect(x: CGFloat(xCen), y: CGFloat(yCen), width: CGFloat(boxWidth), height: CGFloat(boxHeight)))
                let curCen = CGPoint(x: CGFloat(xCen), y: CGFloat(yCen))
                allCenters.append(curCen)
                myImgView.center = curCen
                myImgView.tag = h + v * 4
                print(h, v, h+v*4)
                myImgView.image = UIImage(named: String(format: puzzlePiecesFormat, h + v * 4))
                myImgView.isUserInteractionEnabled = true
                allImgViews.append(myImgView)
                view.addSubview(myImgView)
                
                xCen += boxWidth // move to different column
                
            }
            
            xCen = 49 // restart column to column 1
            yCen += boxHeight // move to different row
            
        }
        view.addSubview(pausePopupView)
    }
    
    
    
    
    // Destroying puzzle
    // -- Remove all photos stored in the array
    func destroyPuzzle(){
        
        for view in allImgViews{
            print("Destroying Puzzle", allImgViews.count)
            view.removeFromSuperview()
            allImgViews.remove(at: 0)
        }
        
        print("Puzzle Left:", allImgViews.count)
        
    }
    
    // Freeze the puzzle
    // -- Disable all swipe gesture
    func freezePuzzle(){
        swipeLeft.isEnabled = false
        swipeRight.isEnabled = false
        swipeUp.isEnabled = false
        swipeDown.isEnabled = false
    }
    
    // UnFreeze the puzzle
    // -- Enable all swipe gesture
    func unFreezePuzzle(){
        
        swipeLeft.isEnabled = true
        swipeRight.isEnabled = true
        swipeUp.isEnabled = true
        swipeDown.isEnabled = true
    }
    
    // Checking win condition
    // User will win if they are able to set all positionCondition to true
    //
    // - Create an array of false position condition
    // - Create a loop that goes through all of the puzzle location
    // -- Inside the loop check whether the correct tag and the correct center are positioned on the right location
    // -- If yes, set the position condition to true, else false
    func checkingWinCondition() -> Bool{
        
        var positionCondition = ["false","false","false","false","false","false","false","false","false","false","false","false","false","false","false"]
        
        var xCen: Int = 49
        var yCen: Int = 200
        
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
            
            // When i reach one of these value, restart xCenter and increase yCen to move to the new row
            // We do this since we are not using the previous h and v for loop like what we did on the createPuzzle()
            if(i == 4 || i == 8 || i == 12){
                xCen = 49
                yCen += 94
                
            }
            
        }
        
        // Checking condition
        // - Check all condition inside the position condition array
        // -- if all condition is true, game is completed
        // -- if one of the condition is false, game is not completed
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
    
    // Randomizing the blocks
    // - Removing the last image view
    // - Inside the loop
    // -- Randomly choose the centers that were kept in an array
    // -- Set the center to view inside the array of UIImageView
    // -- Remove the chosen center from the center array
    // Once we have set all the 15 views inside the image view (suppose to be 16, but we have remove it previously)
    // Set the not leftover center (must be only 1) to be the center of the empty spot
    func randomizeBlocks() {
        
        
        allImgViews[15].removeFromSuperview()
        allImgViews.remove(at: 15)
        
        var centersCopy: [Any] = allCenters
        var randLocInt: Int
        var randLoc: CGPoint
        
        for view in allImgViews {
            
            randLocInt = Int(arc4random_uniform(UInt32(centersCopy.count)))
            print("available location", centersCopy)
            randLoc = centersCopy[randLocInt] as! CGPoint
            print("chosen index", randLocInt, "which is", randLoc)
            view.center = randLoc
            view.alpha = 1
            centersCopy.remove(at: randLocInt) // remove what is used
            
        }
        
        emptySpot = centersCopy[0] as! CGPoint
        print("remaining that doesnt get chosen",emptySpot)
        
    }
    
    // Function to return the center coordinate of the left side of the blank spot
    // Find the center location on the left of the empty spot
    func findSurroundingLeftBox(box: CGPoint) -> CGPoint{
        
        var boxLeft = CGPoint.zero
        boxLeft.x = emptySpot.x - 98
        boxLeft.y = emptySpot.y
        return boxLeft
        
    }
    
    // Function to return the center coordinate of the right side of the blank spot
    // Find the center location on the right of the empty spot
    func findSurroundingRightBox(box: CGPoint) -> CGPoint{
        
        var boxRight = CGPoint.zero
        boxRight.x = emptySpot.x + 98
        boxRight.y = emptySpot.y
        return boxRight
        
    }
    
    // Function to return the center coordinate of the top side of the blank spot
    // Find the center location on the top of the empty spot
    func findSurroundingTopBox(box: CGPoint) -> CGPoint{
        
        var boxTop = CGPoint.zero
        boxTop.x = emptySpot.x
        boxTop.y = emptySpot.y - 94
        return boxTop
        
    }
    
    // Function to return the center coordinate of the bottom side of the blank spot
    // Find the center location on the bottom of the empty spot
    func findSurroundingBottomBox(box: CGPoint) -> CGPoint{
        
        var boxBottom = CGPoint.zero
        boxBottom.x = emptySpot.x
        boxBottom.y = emptySpot.y + 94
        return boxBottom
        
    }
    
    // Function to respond to different swipe gesture
    func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        puzzleSlideSFX?.play()
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            switch swipeGesture.direction {
                
                // - If swipe gesture direction is left
                // -- Find the center of the right box of the empty spot
                // -- If the center location is still inside the bound of the puzzle coordinates
                // -- Then move the right box to the left, else print unable to move
            // -- Lastly, the new coordinates of the empty spot will the center of box that is swaped
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
                
                // - If swipe gesture direction is right
                // -- Find the center of the left box of the empty spot
                // -- If the center location is still inside the bound of the puzzle coordinates
                // -- Then move the left box to the right, else print unable to move
            // -- Lastly, the new coordinates of the empty spot will the center of box that is swaped
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
                
                // - If swipe gesture direction is up
                // -- Find the center of the bottom box of the empty spot
                // -- If the center location is still inside the bound of the puzzle coordinates
                // -- Then move the bottom box to the top, else print unable to move
            // -- Lastly, the new coordinates of the empty spot will the center of box that is swaped
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
                
                // - If swipe gesture direction is down
                // -- Find the center of the top box of the empty spot
                // -- If the center location is still inside the bound of the puzzle coordinates
                // -- Then move the top box to the bottom, else print unable to move
            // -- Lastly, the new coordinates of the empty spot will the center of box that is swaped
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
                            print("box left coordinate", findSurroundingLeftBox(box: emptySpot) ,"\n","box right coordinate",   findSurroundingRightBox(box: emptySpot),"\n","box top coordinate",findSurroundingTopBox(box: emptySpot),"\n","box bottom coordinate",findSurroundingBottomBox(box: emptySpot))
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
        
        // - After every swipe gesture
        // -- Check game condition
        // -- If user able to get the gameCompleted state to be true (from inside the checkingWinCondition())
        gameCompleted = checkingWinCondition()
        
        // If user able to get it true
        // - Stop timer
        // - Count user score
        // - Show the game button
        // - Set back the time and gameCompleted state to be false
        if(gameCompleted == true){
            stopTimer()
            userScore = (minutes * 60) + seconds
            print("userscore",userScore)
            
            yBottomContainer.constant = 0
            UIView.animate(withDuration: 0.2, animations: {
                self.view.layoutIfNeeded()
            })
            gameCompleted = false
            timeIsOn = false
            
            // If userscore is lower than highScore
            // - Meaning that they use lesser time to solve the puzzle
            // - Show HighScore Alert and pass their score
            // Else Show Game End alert
            if(userScore < highScore){
                applauseSFX?.play()
                showingHighScoreAlert(newHighScore: userScore)
                
            }
            else{
                showingGameEndAlert()
                
            }
            
        }
        
    }
    
    // Updating the higscore label inside the game view
    
    
    
    
    func updateHighScoreRecord(){
        
        retrievedName = UserDefaults.standard.object(forKey: savedBestUser) as? String
        retrievedHighScore = UserDefaults.standard.object(forKey: savedHighscore) as? Int
        retrievedTime = UserDefaults.standard.object(forKey: savedBestTime) as? String
        
        if(retrievedName != nil){
            print("best username is", retrievedName)
            savedUsernameLabel.text = "User: " + retrievedName
        }
        else if(retrievedName == nil){
            print("name is null")
            savedUsernameLabel.text = "User: -"
        }
        
        if(retrievedTime != nil){
            
            print("Best time is", retrievedTime)
            savedHighScoreLabel.text = retrievedTime
        }
        else if(retrievedTime == nil){
            print("time is null")
            savedHighScoreLabel.text = "--:--"
        }
        
        if(retrievedHighScore != nil){
            print("highscore is",retrievedHighScore)
            highScore = retrievedHighScore
            
        }
        else if(retrievedHighScore == nil){
            highScore = 20000
        }
        
        //print("new record: username:",retrievedName,"highscore:",highScore,"time:",retrievedTime)
        
    }
    
    /* ======================= Alert Function ======================== */
    
    // Create an alert when the game end
    // Asking the user if they want to redo the game
    func showingGameEndAlert(){
        let alertController = UIAlertController(title: "Puzzle Completed", message: "Save Picture?", preferredStyle: .alert)
        
        let yesAction = UIAlertAction(title: "Yes", style: .default) { (Void) in
            self.savePuzzleImageGallery(image: self.puzzleImg.image!)
            self.resetTimer()
            self.destroyPuzzle()
        }
        
        let noAction = UIAlertAction(title: "No", style: .default) { (Void) in
            self.resetTimer()
            self.destroyPuzzle()
        }
        
        // Adding an action
        alertController.addAction(noAction)
        alertController.addAction(yesAction)
        
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    // Create an alert when the user pass the highscore
    // Asking the user to enter their name
    // Record their name and time
    func showingHighScoreAlert(newHighScore: Int){
        
        let alertController = UIAlertController(title: "New high score!", message: timerLabel.text, preferredStyle: .alert)
        
        // Add the text field
        alertController.addTextField { (textField) in textField.text = "Enter your name here"}
        
        // Grab the value from the text field
        alertController.addAction(UIAlertAction(title: "Enter", style: .default, handler: { [weak alertController] (_) in
            self.highScore = self.userScore
            let textField = alertController?.textFields![0]
            textField?.clearsOnBeginEditing = true
            self.username = (textField?.text)!
            self.showingGameEndAlert()
            
            UserDefaults.standard.set(self.username, forKey: self.savedBestUser)
            UserDefaults.standard.set(self.highScore, forKey: self.savedHighscore)
            // buat trigger highscore
            UserDefaults.standard.set(self.timerLabel.text, forKey: self.savedBestTime)

            self.updateHighScoreRecord()
            
            }))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    /* ======================== Saving Image Function ======================*/
    // Saving the puzzle image to the user's phone gallery
    // - Create the image data and compressed it
    // - Save the compressed image
    // - Add a permission to access photo gallery in info.plist
    func savePuzzleImageGallery(image: UIImage){
        
        let imageData = UIImagePNGRepresentation(image)
        let compressedImage = UIImage(data: imageData!)
        UIImageWriteToSavedPhotosAlbum(compressedImage!, nil, nil, nil)
        print("Image Saved")
        
        /*
         
         Idea from Seemu Apps Youtube Channel
         Link: https://www.youtube.com/watch?v=0IvkfWl4uoI
         
         */
        
    }
    
    // Function to start the game
    @IBAction func startGame(_ sender: AnyObject) {
        buttonPressedSFX?.play()
        createPuzzle()
        randomizeBlocks()
        resetTimer()
        startTimer()
        yBottomContainer.constant = -170
        UIView.animate(withDuration: 0.2, animations: {
            self.view.layoutIfNeeded()
        })
        
    }
    
    // Action to show the pause popup view
    // - Show the pause popup view by changing the center X constraint of the popup view to 0
    // - Set the pause
    @IBAction func showPausePopup(_ sender: AnyObject) {
        
        if (timeIsOn == true){
            
            buttonPressedSFX?.play()
            centerXPausePopupConstraint.constant = 0
            pausePopupView.layer.zPosition = 10
            backgroundButton.layer.zPosition = 10
            
            
            // Slide In Animation
            // - Layout the subview immediately
            // - Set background button alpha to 0.5
            //   (this button is also used to close the view and set 0.5 alpha to
            //   let all the things behind it to have a whitish color)
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
                self.backgroundButton.alpha = 0.5
                self.pausePopupView.alpha = 1
            })
            
            freezePuzzle()
            stopTimer()
        }

        
        
    }
    
    // Action to dismiss the pause popup view
    @IBAction func closePausePopup(_ sender: AnyObject) {
        
        buttonPressedSFX?.play()
        centerXPausePopupConstraint.constant =  -500
        pausePopupView.layer.zPosition = 0
        closePausePopupViewButton.layer.zPosition = 0
        backgroundButton.layer.zPosition = 0
        
        // Slide Out Animation
        // - Layout the subview immediately
        // - Set background button alpha back to 0 (Unviewable and untouchable)
        UIView.animate(withDuration: 0.1, animations: {
            self.view.layoutIfNeeded()
            self.backgroundButton.alpha = 0
            self.pausePopupView.alpha = 0
            
        })
        
        unFreezePuzzle()
        resumeTimer()
    }
    
    @IBAction func backButtonPressed(_ sender: AnyObject) {
        buttonPressedSFX?.play()
    }
    @IBAction func restartingGame(_ sender: AnyObject) {
        
        if(timeIsOn == true){
            buttonPressedSFX?.play()
            stopTimer()
            resetTimer()
            destroyPuzzle()
            gameCompleted = false
            yBottomContainer.constant = 0
            
            UIView.animate(withDuration: 0.2, animations: {
                self.view.layoutIfNeeded()
            })
            
        }
        
    }
}
