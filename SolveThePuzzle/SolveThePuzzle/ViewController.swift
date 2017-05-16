//
//  ViewController.swift
//  SolveThePuzzle
//
//  Created by Amritpal Singh on 4/4/17.
//  Copyright © 2017 Amritpal Singh. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    var passedData: String!
    
    // Outlets for the main screen
    @IBOutlet weak var test: UILabel!
    @IBOutlet weak var logoImageView: UIImageView!
    //@IBOutlet weak var userTimeLabel: UILabel!
    //@IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var clickToStartButton: UIButton!
    
    @IBOutlet weak var musicButton: UIButton!
    @IBOutlet weak var soundFXButton: UIButton!
    @IBOutlet weak var helpButton: UIButton!
    @IBOutlet weak var licenseButton: UIButton!
    @IBOutlet weak var aboutUsButton: UIButton!
    
    // Outlets for the help popup view
    
    
    @IBOutlet weak var closeLicenseButton: UIButton!
    @IBOutlet weak var closeHelpButton: UIButton!
    @IBOutlet weak var closeAboutUsButton: UIButton!
    @IBOutlet weak var closeSettingViewButton: UIButton!
    @IBOutlet weak var backgroundButton: UIButton!
    @IBOutlet weak var centerXPopupConstraint: NSLayoutConstraint!
    @IBOutlet weak var aboutUsCenterX: NSLayoutConstraint!
    @IBOutlet weak var licenseCenterX: NSLayoutConstraint!
    @IBOutlet weak var helpCenterX: NSLayoutConstraint!
    
    @IBOutlet weak var settingPopupView: UIView!
    
    // Initializing Variables
    var homeMusicPlayer1: AVAudioPlayer?
    var buttonPressedSFX: AVAudioPlayer?
    var applauseSFX: AVAudioPlayer?
    var puzzleSlideSFX: AVAudioPlayer?
    
    var musicIsOn = true
    var soundIsOn = true
    
    //    var nameReceived = ""
    //    var bestTimeReceived = ""
    //
    //    var nameSaved = ""
    //    var bestTimeSaved = ""
    
    override func viewDidAppear(_ animated: Bool) {
        // updateHighScoreLabel()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Creating a sound file
        let homeMusicPath1 = Bundle.main.path(forResource: "LittleIdea", ofType: "mp3")
        let homeMusicURL1 = NSURL.fileURL(withPath: homeMusicPath1!)
        
        let buttonPressedSFXPath = Bundle.main.path(forResource: "button-click", ofType: "wav")
        let buttonPressedSFXURL = NSURL.fileURL(withPath: buttonPressedSFXPath!)
        
        let applauseSFXPath = Bundle.main.path(forResource: "applause", ofType: "wav")
        let applauseSFXURL = NSURL.fileURL(withPath: applauseSFXPath!)
        
        let puzzleSlideSFXPath = Bundle.main.path(forResource: "puzzle-slide", ofType: "mp3")
        let puzzleSlideSFXURL = NSURL.fileURL(withPath: puzzleSlideSFXPath!)
        
        // Inserting the sound file to the sound player variable
        // Catch an error if the playback has an issue
        do{
            try homeMusicPlayer1 = AVAudioPlayer(contentsOf: homeMusicURL1)
            
            homeMusicPlayer1?.play()
            homeMusicPlayer1?.numberOfLoops = -1
        }
        catch{print("Player does not work for some reason")}
        
        // For Button SFX
        // Inserting the sound file to the sound player variable
        // Catch an error if the playback has an issue
        do{
            try buttonPressedSFX = AVAudioPlayer(contentsOf: buttonPressedSFXURL)
            
            buttonPressedSFX?.prepareToPlay()
            buttonPressedSFX?.volume = 50
            
        }
        catch{print("Player does not work for some reason")}
        
        do{
            try applauseSFX = AVAudioPlayer(contentsOf: applauseSFXURL)
            
            applauseSFX?.prepareToPlay()
            applauseSFX?.volume = 50
            
        }
        catch{print("Applause SFX does not work for some reason")}
        
        do{
            try puzzleSlideSFX = AVAudioPlayer(contentsOf:puzzleSlideSFXURL)
            
            puzzleSlideSFX?.prepareToPlay()
            puzzleSlideSFX?.volume = 50
            
        }
        catch{print("Player does not work for some reason")}
        
        
        // Set up the setting popup view design
        settingPopupView.layer.cornerRadius = 20
        settingPopupView.layer.masksToBounds = true
        
        if(soundIsOn == true){
            //soundFXButton.setImage(UIImage(named: "pause-button-pressed"), for: .normal)
            buttonPressedSFX?.volume = 50
        }
        else{
            //soundFXButton.setImage(UIImage(named: "pause-button-normal"), for: .normal)
            buttonPressedSFX?.volume = 0
        }
    }
    
    @IBAction func muteUnmuteSound(_ sender: AnyObject) {
        buttonPressedSFX?.play()
        
        if(soundIsOn == true){
            buttonPressedSFX?.play()
            print("sound stop")
            soundFXButton.setImage(UIImage(named: "sound-off-music-on"), for: .normal)
            buttonPressedSFX?.volume = 0
            
            
            // music on but sound is on
            if(musicIsOn == true){
                buttonPressedSFX?.play()
                musicButton.setImage(UIImage(named: "music-on-sound-off"), for: .normal)
                print("ee","musicIsOn:",musicIsOn,"soundIsOn:",soundIsOn)
                
            }else{
                buttonPressedSFX?.play()
                musicButton.setImage(UIImage(named: "music-off-sound-off"), for: .normal)
                print("ff","musicIsOn:",musicIsOn,"soundIsOn:",soundIsOn)
                
            }
            soundIsOn = false
            
        }
        else if(soundIsOn == false){
            buttonPressedSFX?.play()
            print("sound playing")
            soundFXButton.setImage(UIImage(named: "sound-on-music-on"), for: .normal)
            buttonPressedSFX?.volume = 50
            
            
            if(musicIsOn == true){
                buttonPressedSFX?.play()
                musicButton.setImage(UIImage(named: "music-on-sound-on"), for: .normal)
                print("gg","musicIsOn:",musicIsOn,"soundIsOn:",soundIsOn)
                
            }else{
                buttonPressedSFX?.play()
                musicButton.setImage(UIImage(named: "music-off-sound-on"), for: .normal)
                print("hh","musicIsOn:",musicIsOn,"soundIsOn:",soundIsOn)
                
            }
            soundIsOn = true
        }
        
        
        
    }
    
    @IBAction func playStopMusic(_ sender: AnyObject) {
        buttonPressedSFX?.play()
        
        if(musicIsOn == true){
            buttonPressedSFX?.play()
            //print("music stop")
            musicButton.setImage(UIImage(named: "music-off-sound-on"), for: .normal)
            homeMusicPlayer1?.stop()
            
            // music stop but sound is on
            if(soundIsOn == true){
                buttonPressedSFX?.play()
                soundFXButton.setImage(UIImage(named: "sound-on-music-off"), for: .normal)
                print("aa","musicIsOn:",musicIsOn,"soundIsOn:",soundIsOn)
                
            }else{
                buttonPressedSFX?.play()
                soundFXButton.setImage(UIImage(named: "sound-off-music-off"), for: .normal)
                print("mute sound")
                print("bb","musicIsOn:",musicIsOn,"soundIsOn:",soundIsOn)
                
            }
            musicIsOn = false
            
        }
        else if(musicIsOn == false){
            buttonPressedSFX?.play()
            print("music playing")
            musicButton.setImage(UIImage(named: "music-on-sound-on"), for: .normal)
            homeMusicPlayer1?.play()
            
            
            if(soundIsOn == true){
                buttonPressedSFX?.play()
                soundFXButton.setImage(UIImage(named: "sound-on-music-on"), for: .normal)
                print("cc","musicIsOn:",musicIsOn,"soundIsOn:",soundIsOn)
                
            }else{
                buttonPressedSFX?.play()
                soundFXButton.setImage(UIImage(named: "sound-off-music-on"), for: .normal)
                print("dd","musicIsOn:",musicIsOn,"soundIsOn:",soundIsOn)
                
            }
            musicIsOn = true
        }
        
    }
    
    
    @IBAction func openAboutUsView(_ sender: AnyObject) {
        
        buttonPressedSFX?.play()
        aboutUsCenterX.constant = 0
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
            self.backgroundButton.alpha = 0.5
        })
    }
    
    @IBAction func openHelpView(_ sender: AnyObject) {
        
        buttonPressedSFX?.play()
        helpCenterX.constant = 0
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
            self.backgroundButton.alpha = 0.5
        })
    }
    
    @IBAction func openLicenseView(_ sender: AnyObject) {
        
        buttonPressedSFX?.play()
        licenseCenterX.constant = 0
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
            self.backgroundButton.alpha = 0.5
        })
    }
    
    @IBAction func closeLicensePopup(_ sender: AnyObject) {
        buttonPressedSFX?.play()
        licenseCenterX.constant = -500
        UIView.animate(withDuration: 0.1, animations: {
            self.view.layoutIfNeeded()
            self.backgroundButton.alpha = 0
        })
    }
    
    @IBAction func closeHelpPopup(_ sender: AnyObject) {
        buttonPressedSFX?.play()
        helpCenterX.constant = -500
        UIView.animate(withDuration: 0.1, animations: {
            self.view.layoutIfNeeded()
            self.backgroundButton.alpha = 0
        })
    }
    
    // Action to show the setting popup view
    // - Show view by setting the X contraint to be 0
    // - Start Sliding Animation
    @IBAction func showSettingPopup(_ sender: AnyObject) {
        buttonPressedSFX?.play()
        
        centerXPopupConstraint.constant = 0
        
        // Slide In Animation
        // - Layout the subview immediately
        // - Set background button alpha to 0.5
        //   (this button is also used to close the view and set 0.5 alpha to
        //   let all the things behind it to have a whitish color)
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
            self.backgroundButton.alpha = 0.5
        })
    }
    
    @IBAction func closeAboutUsPopup(_ sender: AnyObject) {
        buttonPressedSFX?.play()
        aboutUsCenterX.constant = -500
        UIView.animate(withDuration: 0.1, animations: {
            self.view.layoutIfNeeded()
            self.backgroundButton.alpha = 0
        })
    }
    
    
    // Action to dismiss the setting popup view
    @IBAction func closeSettingPopup(_ sender: AnyObject) {
        buttonPressedSFX?.play()
        centerXPopupConstraint.constant =  -500
        
        // Slide Out Animation
        // - Layout the subview immediately
        // - Set background button alpha back to 0 (Unviewable and untouchable)
        UIView.animate(withDuration: 0.1, animations: {
            self.view.layoutIfNeeded()
            self.backgroundButton.alpha = 0
        })
        
    }
    
    @IBAction func backgroundButton(_ sender: AnyObject) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toPuzzleSelection" {
            let destVc = segue.destination as! PuzzleSelectionViewController
            destVc.musicIsOn = musicIsOn
            destVc.soundIsOn = soundIsOn
        }
    }
    
    // Go back to Home Page Function
    @IBAction func exitToHomeScene(sender: UIStoryboardSegue){
        
       if let sourceViewController = sender.source as? PuzzleSelectionViewController {
            musicIsOn = sourceViewController.musicIsOn
            soundIsOn = sourceViewController.soundIsOn
        
        print("first 2scene music is on",musicIsOn)
        print("first 2scene sound is on",soundIsOn)

        }
            
        
        //        if let sourceViewController = sender.source as? PuzzleGameViewController {
        //            nameReceived = sourceViewController.retrievedName
        //            bestTimeReceived = sourceViewController.retrievedTime
        //            savingRecord(name: nameReceived, bestTime: bestTimeReceived)
        //            updateHighScoreLabel()
        //        }
        
    }
    
    //    // Override the unwind function
    //    override func unwind(for unwindSegue: UIStoryboardSegue, towardsViewController subsequentVC: UIViewController) {
    //        let segue = UnwindScaleSegue(identifier: unwindSegue.identifier, source: unwindSegue.source, destination: unwindSegue.destination)
    //        segue.perform()
    //    }
    
    //    func updateHighScoreLabel(){
    //
    //        nameReceived = (UserDefaults.standard.object(forKey: "savedName") as? String)!
    //        bestTimeReceived = (UserDefaults.standard.object(forKey: "savedTime") as? String)!
    //
    //        if(nameReceived != nil){
    //            timeLabel.text = nameReceived
    //        }
    //        else{
    //            print("name is null")
    //        }
    //
    //        if(bestTimeReceived != nil){
    //            userTimeLabel.text = bestTimeReceived
    //        }
    //        else{
    //            print("time is null")
    //        }
    //
    //    }
    
    //    func savingRecord(name: String, bestTime: String){
    //        
    //        UserDefaults.standard.set(name, forKey: "savedName")
    //        UserDefaults.standard.set(bestTime, forKey: "savedTime")
    //        
    //    }
    
}
