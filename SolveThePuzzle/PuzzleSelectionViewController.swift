//
//  PuzzleSelectionViewController.swift
//  SolveThePuzzle
//
//  Created by Michael Hartanto on 5/13/17.
//  Copyright © 2017 Amritpal Singh. All rights reserved.
//

import UIKit
import AVFoundation

class PuzzleSelectionViewController: UIViewController {
    
    // Variable to send picture data to the game controller
    var pictureSelected = "default"
    var puzzlePiecesFormat = "default"
    var buttonPressedSFX: AVAudioPlayer?

    // Sound State Variable
    var soundIsOn = true
    
    @IBOutlet var puzzleCollection: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Creating the audio file for different SFX
        let buttonPressedSFXPath = Bundle.main.path(forResource: "buttonSFX", ofType: "wav")
        let buttonPressedSFXURL = NSURL.fileURL(withPath: buttonPressedSFXPath!)
        
        // For Button SFX
        // Inserting the sound file to the sound player variable
        // Catch an error if the playback has an issue
        do{
            try buttonPressedSFX = AVAudioPlayer(contentsOf: buttonPressedSFXURL)
            
            buttonPressedSFX?.prepareToPlay()
            
        }
        catch{print("Player does not work for some reason")}

        // If sound state that is sent from previous view is true
        // Then set the volume for the sfx to 5
        // Else mute the volume of the sfx
        if(soundIsOn == true){
            buttonPressedSFX?.volume = 5
        }
        else{
            buttonPressedSFX?.volume = 0
        }

        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // Function to perform segue to the game controller
    // - Using case to identify which button tag is pressed (which puzzle is pressed)
    // - Set the name of the picture puzzle that is selected to be use in the game controller
    @IBAction func openGameScene(_ sender: AnyObject) {
        
        buttonPressedSFX?.play()
        
        switch(sender.tag){
        case 0:
            pictureSelected = "puzzle1"
            puzzlePiecesFormat = "puzzle1_%02i.jpg"
            print(pictureSelected)
            
            performSegue(withIdentifier: "toGame", sender: self)
            
            break
        case 1:
            pictureSelected = "puzzle2"
            puzzlePiecesFormat = "puzzle2_%02i.jpg"
            print(pictureSelected)
            
            performSegue(withIdentifier: "toGame", sender: self)
            break
            
        case 2:
            pictureSelected = "puzzle3"
            puzzlePiecesFormat = "puzzle3_%02i.jpg"
            performSegue(withIdentifier: "toGame", sender: self)
            
            break
            
        case 3:
//            pictureSelected = "tree"
//            puzzlePiecesFormat = "tr_%02i.jpg"
//            
//            performSegue(withIdentifier: "toGame", sender: self)
            
            break
            
        case 4:

            
            break
            
        case 5:
            break
            
        case 6:

            break
            
        case 7:

            break
            
        case 8:

            break
            
        case 9:

            break
            
        case 10:

            break
            
        case 11:
            break
            
        default:
            break
        }
    }
    
    // Go back to home view controller
    @IBAction func backButtonPressed(_ sender: AnyObject) {
        buttonPressedSFX?.play()
    }
    
    // Function to go from one segue to other
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Identify the segue identifier
        // - If it is toGame then:
        // - Set the destination view controller to game view controller
        // - Set a value for the variables inside the game view controller
        // - Send:
        // -- the name of the puzzle
        // -- the format for the puzzle pieces 
        // -- key name to save the username, time and highscore
        // -- sound state
        if segue.identifier == "toGame" {
            buttonPressedSFX?.play()
            let destVc = segue.destination as! GameViewController
            destVc.pictureName = pictureSelected
            destVc.puzzlePiecesFormat = puzzlePiecesFormat
            destVc.savedBestUser = pictureSelected + destVc.savedBestUser
            destVc.savedBestTime = pictureSelected + destVc.savedBestTime
            destVc.savedHighscore = pictureSelected + destVc.savedHighscore
            destVc.soundIsOn = soundIsOn
        }
        
    }
    
    // Go back to Puzzle Selection Page Function
    @IBAction func exitToLevelScene(sender: UIStoryboardSegue){
        
        //        if let sourceViewController = sender.source as? PuzzleGameViewController {
        //            nameReceived = sourceViewController.retrievedName
        //            bestTimeReceived = sourceViewController.retrievedTime
        //            savingRecord(name: nameReceived, bestTime: bestTimeReceived)
        //            updateHighScoreLabel()
        //        }
        
    }
    
}

