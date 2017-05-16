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
    
    var pictureSelected = "default"
    var puzzlePiecesFormat = "default"
    var buttonPressedSFX: AVAudioPlayer?

    var soundIsOn = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let buttonPressedSFXPath = Bundle.main.path(forResource: "buttonSFX", ofType: "wav")
        let buttonPressedSFXURL = NSURL.fileURL(withPath: buttonPressedSFXPath!)

        print("sound is on",soundIsOn)
        
        // For Button SFX
        // Inserting the sound file to the sound player variable
        // Catch an error if the playback has an issue
        do{
            try buttonPressedSFX = AVAudioPlayer(contentsOf: buttonPressedSFXURL)
            
            buttonPressedSFX?.prepareToPlay()
            
        }
        catch{print("Player does not work for some reason")}

        
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
    
    @IBOutlet var puzzleCollection: [UIButton]!
    
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
    
    @IBAction func backButtonPressed(_ sender: AnyObject) {
        buttonPressedSFX?.play()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
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
    
    // Go back to Home Page Function
    @IBAction func exitToLevelScene(sender: UIStoryboardSegue){
        
        //        if let sourceViewController = sender.source as? PuzzleGameViewController {
        //            nameReceived = sourceViewController.retrievedName
        //            bestTimeReceived = sourceViewController.retrievedTime
        //            savingRecord(name: nameReceived, bestTime: bestTimeReceived)
        //            updateHighScoreLabel()
        //        }
        
    }
    
}

