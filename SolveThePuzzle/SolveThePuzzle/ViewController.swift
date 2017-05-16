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
    

    override func viewDidAppear(_ animated: Bool) {

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Creating a sound file
        let homeMusicPath1 = Bundle.main.path(forResource: "Gameplay", ofType: "mp3")
        let homeMusicURL1 = NSURL.fileURL(withPath: homeMusicPath1!)
        
        let buttonPressedSFXPath = Bundle.main.path(forResource: "buttonSFX", ofType: "wav")
        let buttonPressedSFXURL = NSURL.fileURL(withPath: buttonPressedSFXPath!)
        
        // Inserting the sound file to the sound player variable
        // Catch an error if the playback has an issue
        do{
            try homeMusicPlayer1 = AVAudioPlayer(contentsOf: homeMusicURL1)
            playMusic()
            //homeMusicPlayer1?.play()
            //homeMusicPlayer1?.numberOfLoops = -1
        }
        catch{print("Player does not work for some reason")}
        
        // For Button SFX
        // Inserting the sound file to the sound player variable
        // Catch an error if the playback has an issue
        do{
            try buttonPressedSFX = AVAudioPlayer(contentsOf: buttonPressedSFXURL)
            buttonPressedSFX?.prepareToPlay()
        }
        catch{print("Player does not work for some reason")}
        
        // Set up the setting popup view design
        settingPopupView.layer.cornerRadius = 20
        settingPopupView.layer.masksToBounds = true
    
        if(soundIsOn == true){
            buttonPressedSFX?.volume = 5
        }
        else{
            buttonPressedSFX?.volume = 0
        }
        
        /*
         
         Idea to stop music background when user close the application
         Thomas a, stackoverflow
         
         */
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector (pauseSong), name:NSNotification.Name.UIApplicationWillResignActive, object: nil)
        
        notificationCenter.addObserver(self, selector: #selector (resumeSong), name:NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
        
    }
    
    func pauseSong(notification : NSNotification) {
        homeMusicPlayer1?.pause()
        //homeMusicPlayer1?.stop()

    }
    
    func resumeSong(notification : NSNotification) {
        homeMusicPlayer1?.play()
        
    }
    
    func stopMusic(){
        homeMusicPlayer1?.stop()
    }
    
    func playMusic(){
        homeMusicPlayer1?.play()
        homeMusicPlayer1?.numberOfLoops = -1
    }
    
    @IBAction func playButtonPressed(_ sender: AnyObject) {
        buttonPressedSFX?.play()

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
            buttonPressedSFX?.volume = 5
            
            
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
            stopMusic()
            
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
            playMusic()
            
            
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
            self.backgroundButton.alpha = 0
        })
    }
    
    @IBAction func openHelpView(_ sender: AnyObject) {
        
        buttonPressedSFX?.play()
        helpCenterX.constant = 0
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
            self.backgroundButton.alpha = 0
        })
    }
    
    @IBAction func openLicenseView(_ sender: AnyObject) {
        
        buttonPressedSFX?.play()
        licenseCenterX.constant = 0
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
            self.backgroundButton.alpha = 0
        })
    }
    
    @IBAction func closeLicensePopup(_ sender: AnyObject) {
        buttonPressedSFX?.play()
        licenseCenterX.constant = -500
        UIView.animate(withDuration: 0.1, animations: {
            self.view.layoutIfNeeded()
            self.backgroundButton.alpha = 0.5
        })
    }
    
    @IBAction func closeHelpPopup(_ sender: AnyObject) {
        buttonPressedSFX?.play()
        helpCenterX.constant = -500
        UIView.animate(withDuration: 0.1, animations: {
            self.view.layoutIfNeeded()
            self.backgroundButton.alpha = 0.5
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
            self.backgroundButton.alpha = 0.5
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toPuzzleSelection" {
            let destVc = segue.destination as! PuzzleSelectionViewController
            destVc.soundIsOn = soundIsOn
        }
    }
    
    // Go back to Home Page Function
    @IBAction func exitToHomeScene(sender: UIStoryboardSegue){

    }
    
}
