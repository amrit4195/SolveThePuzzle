//
//  PuzzleSelectionViewController.swift
//  SolveThePuzzle
//
//  Created by Michael Hartanto on 5/13/17.
//  Copyright © 2017 Amritpal Singh. All rights reserved.
//

import UIKit
import AVFoundation
<<<<<<< HEAD
=======

>>>>>>> origin/master
class PuzzleSelectionViewController: UIViewController {
    
    var pictureSelected = "default"
    var puzzlePiecesFormat = "default"
<<<<<<< HEAD
    var buttonPressedSFX: AVAudioPlayer?
=======
    var musicIsOn = true
    var soundIsOn = true
>>>>>>> origin/master
    
    var buttonPressedSFX: AVAudioPlayer?
    
    
    
    @IBOutlet weak var soundFXButton: UIButton!
    @IBAction func muteUnmuteSound(_ sender: AnyObject) {
        
        buttonPressedSFX?.play()

        if(soundIsOn == true){
            soundFXButton.setImage(UIImage(named: "pause-button-normal"), for: .normal)
            buttonPressedSFX?.volume = 0
            soundIsOn = false
        }
        else{
            soundFXButton.setImage(UIImage(named: "pause-button-pressed"), for: .normal)
            buttonPressedSFX?.volume = 50
            soundIsOn = true
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let buttonPressedSFXPath = Bundle.main.path(forResource: "button-click", ofType: "wav")
        let buttonPressedSFXURL = NSURL.fileURL(withPath: buttonPressedSFXPath!)
        
<<<<<<< HEAD
=======
        print("music is on",musicIsOn)
        print("sound is on",soundIsOn)
        
        let buttonPressedSFXPath = Bundle.main.path(forResource: "buttonSFX", ofType: "wav")
        let buttonPressedSFXURL = NSURL.fileURL(withPath: buttonPressedSFXPath!)
        
        // For Button SFX
        // Inserting the sound file to the sound player variable
        // Catch an error if the playback has an issue
>>>>>>> origin/master
        do{
            try buttonPressedSFX = AVAudioPlayer(contentsOf: buttonPressedSFXURL)
            
            buttonPressedSFX?.prepareToPlay()
            buttonPressedSFX?.volume = 50
            
        }
        catch{print("Player does not work for some reason")}
<<<<<<< HEAD

=======
        
        if(soundIsOn == true){
            soundFXButton.setImage(UIImage(named: "pause-button-pressed"), for: .normal)
            buttonPressedSFX?.volume = 50
        }
        else{
            soundFXButton.setImage(UIImage(named: "pause-button-normal"), for: .normal)
            buttonPressedSFX?.volume = 0
        }

        
>>>>>>> origin/master
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet var puzzleCollection: [UIButton]!
    
    @IBAction func openGameScene(_ sender: AnyObject) {
        buttonPressedSFX?.play()
        
        buttonPressedSFX?.play()
        
        switch(sender.tag){
        case 0:
            buttonPressedSFX?.play()
            pictureSelected = "puzzle1"
            puzzlePiecesFormat = "puzzle1_%02i.jpg"
            print(pictureSelected)
            
            performSegue(withIdentifier: "toGame", sender: self)
            
            break
        case 1:
            buttonPressedSFX?.play()
            pictureSelected = "puzzle2"
            puzzlePiecesFormat = "puzzle2_%02i.jpg"
            print(pictureSelected)
            
            performSegue(withIdentifier: "toGame", sender: self)
            break
            
        case 2:
            buttonPressedSFX?.play()
            pictureSelected = "puzzle3"
            puzzlePiecesFormat = "puzzle3_%02i.jpg"
            
            performSegue(withIdentifier: "toGame", sender: self)
            
            break
            
        case 3:
<<<<<<< HEAD
            buttonPressedSFX?.play()
            pictureSelected = "tree"
            puzzlePiecesFormat = "tr_%02i.jpg"
            
            performSegue(withIdentifier: "toGame", sender: self)
            
            break
            
        case 4:
            buttonPressedSFX?.play()
            pictureSelected = "app_image"
            
            performSegue(withIdentifier: "toGame", sender: self)
=======
            //pictureSelected = "tree"
            //puzzlePiecesFormat = "tr_%02i.jpg"
            //performSegue(withIdentifier: "toGame", sender: self)


            break
            
        case 4:
>>>>>>> origin/master
            
            break
            
        case 5:
<<<<<<< HEAD
            buttonPressedSFX?.play()
            pictureSelected = "tree"
            
            performSegue(withIdentifier: "toGame", sender: self)
            
            break
            
        case 6:
            buttonPressedSFX?.play()
            pictureSelected = "app_image"
            
            performSegue(withIdentifier: "toGame", sender: self)
            
            break
            
        case 7:
            buttonPressedSFX?.play()
            pictureSelected = "tree"
            
            performSegue(withIdentifier: "toGame", sender: self)
            
            break
            
        case 8:
            buttonPressedSFX?.play()
            pictureSelected = "app_image"
            
            performSegue(withIdentifier: "toGame", sender: self)
            
            break
            
        case 9:
            buttonPressedSFX?.play()
            pictureSelected = "tree"
            
            performSegue(withIdentifier: "toGame", sender: self)
            
            break
            
        case 10:
            buttonPressedSFX?.play()
            pictureSelected = "app_image"
            
            performSegue(withIdentifier: "toGame", sender: self)
            
            break
            
        case 11:
            buttonPressedSFX?.play()
            pictureSelected = "tree"
            
            performSegue(withIdentifier: "toGame", sender: self)
            
=======

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

>>>>>>> origin/master
            break
            
        default:
            break
        }
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
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

