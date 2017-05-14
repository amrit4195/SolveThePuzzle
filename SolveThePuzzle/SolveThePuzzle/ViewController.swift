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
    @IBOutlet weak var closeSettingViewButton: UIButton!
    @IBOutlet weak var backgroundButton: UIButton!
    @IBOutlet weak var centerXPopupConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var settingPopupView: UIView!
    
    // Initializing Variables
    var homeMusicPlayer1: AVAudioPlayer?
    var buttonPressedSFX: AVAudioPlayer?
    
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
        
        //test.text = passedData
        
        // Creating a sound file
        let homeMusicPath1 = Bundle.main.path(forResource: "LittleIdea", ofType: "mp3")
        let homeMusicURL1 = NSURL.fileURL(withPath: homeMusicPath1!)
        
        let buttonPressedSFXPath = Bundle.main.path(forResource: "buttonSFX", ofType: "wav")
        let buttonPressedSFXURL = NSURL.fileURL(withPath: buttonPressedSFXPath!)
        
        // Inserting the sound file to the sound player variable
        // Catch an error if the playback has an issue
        do{
            try homeMusicPlayer1 = AVAudioPlayer(contentsOf: homeMusicURL1)
            
            homeMusicPlayer1?.play()
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
        
        
        // Set up the setting popup view design
        settingPopupView.layer.cornerRadius = 20
        settingPopupView.layer.masksToBounds = true
        
        musicIsOn = true
        soundIsOn = true
    }
    
    @IBAction func muteUnmuteSound(_ sender: AnyObject) {
        
        if(soundIsOn == true){
            print("sound stop")
            soundFXButton.setImage(UIImage(named: "sound-off-music-on"), for: .normal)
            buttonPressedSFX?.volume = 0
            
            
            // music on but sound is on
            if(musicIsOn == true){
                musicButton.setImage(UIImage(named: "music-on-sound-off"), for: .normal)
                print("ee","musicIsOn:",musicIsOn,"soundIsOn:",soundIsOn)
                
            }else{
                musicButton.setImage(UIImage(named: "music-off-sound-off"), for: .normal)
                print("ff","musicIsOn:",musicIsOn,"soundIsOn:",soundIsOn)
                
            }
            soundIsOn = false
            
        }
        else if(soundIsOn == false){
            print("sound playing")
            soundFXButton.setImage(UIImage(named: "sound-on-music-on"), for: .normal)
            buttonPressedSFX?.volume = 50
            
            
            if(musicIsOn == true){
                musicButton.setImage(UIImage(named: "music-on-sound-on"), for: .normal)
                print("gg","musicIsOn:",musicIsOn,"soundIsOn:",soundIsOn)
                
            }else{
                musicButton.setImage(UIImage(named: "music-off-sound-on"), for: .normal)
                print("hh","musicIsOn:",musicIsOn,"soundIsOn:",soundIsOn)
                
            }
            soundIsOn = true
        }
        
        
        
    }
    
    @IBAction func playStopMusic(_ sender: AnyObject) {
        
        if(musicIsOn == true){
            //print("music stop")
            musicButton.setImage(UIImage(named: "music-off-sound-on"), for: .normal)
            homeMusicPlayer1?.stop()
            
            // music stop but sound is on
            if(soundIsOn == true){
                soundFXButton.setImage(UIImage(named: "sound-on-music-off"), for: .normal)
                print("aa","musicIsOn:",musicIsOn,"soundIsOn:",soundIsOn)
                
            }else{
                soundFXButton.setImage(UIImage(named: "sound-off-music-off"), for: .normal)
                print("mute sound")
                print("bb","musicIsOn:",musicIsOn,"soundIsOn:",soundIsOn)
                
            }
            musicIsOn = false
            
        }
        else if(musicIsOn == false){
            print("music playing")
            musicButton.setImage(UIImage(named: "music-on-sound-on"), for: .normal)
            homeMusicPlayer1?.play()
            
            
            if(soundIsOn == true){
                soundFXButton.setImage(UIImage(named: "sound-on-music-on"), for: .normal)
                print("cc","musicIsOn:",musicIsOn,"soundIsOn:",soundIsOn)
                
            }else{
                soundFXButton.setImage(UIImage(named: "sound-off-music-on"), for: .normal)
                print("dd","musicIsOn:",musicIsOn,"soundIsOn:",soundIsOn)
                
            }
            musicIsOn = true
        }
        
    }
    
    
    @IBAction func openAboutUsView(_ sender: AnyObject) {
        
        buttonPressedSFX?.play()
    }
    
    // Action to show the setting popup view
    // - Show view by setting the X contraint to be 0
    // - Start Sliding Animation
    @IBAction func showSettingPopup(_ sender: AnyObject) {
        
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
    
    
    
    // Action to dismiss the setting popup view
    @IBAction func closeSettingPopup(_ sender: AnyObject) {
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
    
    // Go back to Home Page Function
    @IBAction func exitToHomeScene(sender: UIStoryboardSegue){
        
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

/*
 // blinking animation
 UIView.animate(withDuration: 1, delay: 0.0, options: [.repeat,.autoreverse,.allowUserInteraction], animations: {
 self.clickToStartButton.alpha = 0.1 //disappear
 self.clickToStartButton.alpha = 1.0 // appear
 }, completion: nil)
 */
