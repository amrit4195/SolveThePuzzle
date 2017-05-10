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

    var highScore = 0
    var userScore = 0
    var username = ""
    
    var swipeLeft: UISwipeGestureRecognizer!
    var swipeRight: UISwipeGestureRecognizer!
    var swipeUp: UISwipeGestureRecognizer!
    var swipeDown: UISwipeGestureRecognizer!
    
    @IBOutlet weak var pausePuzzleImageView: UIImageView!
    @IBOutlet weak var pausePopupView: UIView!
    @IBOutlet weak var backgroundButton: UIButton!
    @IBOutlet weak var centerXPopupConstraint: NSLayoutConstraint!
    @IBOutlet weak var pauseGameButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var savedHighScoreLabel: UILabel!
    @IBOutlet weak var startGameButton: UIButton!
    @IBOutlet weak var savedUsernameLabel: UILabel!
    @IBOutlet weak var closePausePopupViewButton: UIButton!
    
    @IBOutlet weak var restartGameButton: UIButton!
    override func viewDidLoad() {
    
        resetTimer()
        
        pausePopupView.alpha = 0
        //pausePopupView.layer.zPosition = 0
        //closePausePopupViewButton.layer.zPosition = 0
        pausePuzzleImageView.image = UIImage(named: "app_image")
        restartGameButton.alpha = 0
        pauseGameButton.alpha = 0
        //backgroundButton.layer.zPosition = 0
        createPuzzleTemplate()
        
        // Set up the pause popup view design
        pausePopupView.layer.cornerRadius = 20
        pausePopupView.layer.masksToBounds = true
        
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
    
    override func viewDidAppear(_ animated: Bool) {
       // let name : String? = UserDefaults.standard.object(forKey: "name") as? String
        
        //updateHighScoreRecord(name: retrievedName, newHighScore: retrievedHighScore, time: retrievedTime)
        updateHighScoreRecord()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /* ===================== Function for time ========================*/
    
    func startTimer(){
        
        timeIsOn = true
        
        // Call the updateTime function every 1 second
        gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        
        // When timer is on
        if (timeIsOn == true){
            
            // Hide the start button
            startGameButton.isHidden = true;
        }
        
    }
    
    func stopTimer(){
        
        // Stop Timer
        gameTimer.invalidate()
        
        // Save paused time
        pauseTime = timerLabel.text!
        
    }
    
    func resumeTimer(){
        
        // Show paused time
        timerLabel.text = pauseTime
        
        // Start timer/Resume timer again
        gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        
    }
    
    
    func resetTimer(){
        
        // Start the timer from 00:00
        seconds = 0
        minutes = 0
        timerLabel.text = "0\(minutes):0\(seconds)"
        timeIsOn = false
        
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

    /* ===================== Function for Game ========================*/
    
    // Function to start the game
    @IBAction func startGame(_ sender: AnyObject) {
        
        createPuzzle()
        randomizeBlocks()
        resetTimer()
        startTimer()
        pauseGameButton.alpha = 1
        restartGameButton.alpha = 1
        
    }
    
    // Creating template for the puzzle
    // Show user the dark original photo of the puzzle for hints
    func createPuzzleTemplate(){
        
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
        
        let puzzleImg = UIImageView(frame: CGRect(x: CGFloat(xCen), y: CGFloat(yCen), width: CGFloat(darkBoxWidth), height: CGFloat(darkBoxHeight)))
        puzzleImg.image = UIImage(named: "app_image")
        let puzzleImgCen = CGPoint(x: CGFloat(darkBoxWidth / 2), y: CGFloat(yCen + boxHeight + (boxHeight/2)))
        puzzleImg.center = puzzleImgCen
        puzzleImg.alpha = 0.3
        view.addSubview(puzzleImg)
        
    }
    
    // Creating the puzzle
    // -- Removing the last photo array
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
                myImgView.image = UIImage(named: String(format: "ai_%02i.jpg", h + v * 4))
                myImgView.isUserInteractionEnabled = true
                //myImgView.alpha = 0.3
                allImgViews.append(myImgView)
                view.addSubview(myImgView)
                view.addSubview(pausePopupView)

                xCen += boxWidth
                
            }
            
            xCen = 49
            yCen += boxHeight
            
        }
        
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
    // -- When the user pause the game
    // -- Disable all swipe gesture
    func freezePuzzle(){
        swipeLeft.isEnabled = false
        swipeRight.isEnabled = false
        swipeUp.isEnabled = false
        swipeDown.isEnabled = false
    }
    
    // UnFreeze the puzzle
    // -- When the user resume the game
    // -- Enable all swipe gesture
    func unFreezePuzzle(){
        
        swipeLeft.isEnabled = true
        swipeRight.isEnabled = true
        swipeUp.isEnabled = true
        swipeDown.isEnabled = true
    }
    
    // Checking win condition
    // User will win if they are able to set all positionCondition to true
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
            
            if(i == 4 || i == 8 || i == 12){
                xCen = 49
                yCen += 94
                
            }
            
        }
        
        // checking condition
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
            view.alpha = 1
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
        gameCompleted = true
        if(gameCompleted == true){
            
            stopTimer()
            userScore = (minutes * 60) + seconds
            print("userscore",userScore)
            startGameButton.isHidden = false
            gameCompleted = false
            timeIsOn = false
            
            if(userScore > highScore){
                showingHighScoreAlert(newHighScore: userScore)
                
            }
            else{
                showingGameEndAlert()
                
            }
            
        }
        
    }
    
    func updateHighScoreRecord(){
        let retrievedName : String! = UserDefaults.standard.object(forKey: "savedName") as? String
        let retrievedHighScore : Int! = UserDefaults.standard.object(forKey: "savedHighScore") as? Int
        let retrievedTime : String! = UserDefaults.standard.object(forKey: "savedTime") as? String
        
        if(retrievedName != nil){
            print("est username is", retrievedName)
            savedUsernameLabel.text = "User: " + retrievedName
        }
        else{
            print("name is null")
            savedUsernameLabel.text = "User: -"
        }
        
        if(retrievedTime != nil){
            
            print("Best time is", retrievedTime)
            savedHighScoreLabel.text = "Best Time: " + retrievedTime
        }
        else{
            print("time is null")
            savedHighScoreLabel.text = "Best Time: xx:xx"
        }
        
        if(retrievedHighScore != nil){
            print("highscore is",retrievedHighScore)
            highScore = retrievedHighScore
            
        }
        else{
            highScore = 0
        }
        
        print("new record: username:",retrievedName,"highscore:",highScore,"time:",retrievedTime)
        
    }
    
/* ======================= Alert Function ======================== */
    
    // Create an alert when the game end
    // Asking the user if they want to redo the game
    func showingGameEndAlert(){
        let alertController = UIAlertController(title: "Puzzle Completed", message: "Save Picture?", preferredStyle: .alert)
        
        let yesAction = UIAlertAction(title: "Yes", style: .default) { (Void) in
            self.restartGameButton.alpha = 0
            self.pauseGameButton.alpha = 0
            self.resetTimer()
            self.destroyPuzzle()
        }
        
        let noAction = UIAlertAction(title: "No", style: .default) { (Void) in
            self.restartGameButton.alpha = 0
            self.pauseGameButton.alpha = 0
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
            
            UserDefaults.standard.set(self.username, forKey: "savedName")
            UserDefaults.standard.set(self.highScore, forKey: "savedHighScore") // buat trigger highscore
            UserDefaults.standard.set(self.timerLabel.text, forKey: "savedTime")
            
            //self.updateHighScoreRecord(name: self.retrievedName, newHighScore: self.retrievedHighScore, time: self.retrievedTime)
            self.updateHighScoreRecord()

            }))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    // Action to show the pause popup view
    @IBAction func showPausePopup(_ sender: AnyObject) {
        
        centerXPopupConstraint.constant = 0
        pausePopupView.layer.zPosition = 10
        closePausePopupViewButton.layer.zPosition = 11
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
        timeIsOn = false
        
    }
    
    // Action to dismiss the pause popup view
    @IBAction func closePausePopup(_ sender: AnyObject) {
        centerXPopupConstraint.constant =  -500
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
        timeIsOn = true
        
    }
    
    @IBAction func restartingGame(_ sender: AnyObject) {
        stopTimer()

        startGameButton.isHidden = false
        gameCompleted = false
        timeIsOn = false
        restartGameButton.alpha = 0
        pauseGameButton.alpha = 0
        resetTimer()
        destroyPuzzle()
    }
}


// MARK: - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
//override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
// Get the new view controller using segue.destinationViewController.
// Pass the selected object to the new view controller.
//}

//
//    @IBAction func goToVC(_ sender: AnyObject) {
//        //let userInput = timerLabel.text
//        performSegue(withIdentifier: "goToVC", sender: userScore)
//    }
//
