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
    
    // Outlets for the main screen
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var clickToStartButton: UIButton!
    @IBOutlet weak var musicButton: UIButton!
    @IBOutlet weak var soundFXButton: UIButton!
    @IBOutlet weak var helpButton: UIButton!
    @IBOutlet weak var licenseButton: UIButton!
    @IBOutlet weak var aboutUsButton: UIButton!
    
    @IBOutlet weak var backgroundButton: UIButton!
    
    // Outlets for the settings popup view
    @IBOutlet weak var settingPopupView: UIView!
    @IBOutlet weak var centerXPopupConstraint: NSLayoutConstraint!
    @IBOutlet weak var closeSettingViewButton: UIButton!

    // Outlets for the about us popup view
    @IBOutlet weak var aboutUsCenterX: NSLayoutConstraint!
    @IBOutlet weak var closeAboutUsButton: UIButton!
    
    // Outlets for the license popup view
    @IBOutlet weak var licenseCenterX: NSLayoutConstraint!
    @IBOutlet weak var closeLicenseButton: UIButton!

    // Outlets for the help popup view
    @IBOutlet weak var helpCenterX: NSLayoutConstraint!
    @IBOutlet weak var closeHelpButton: UIButton!

    // Audio player variables
    var homeMusicPlayer1: AVAudioPlayer?
    var buttonPressedSFX: AVAudioPlayer?
    var applauseSFX: AVAudioPlayer?
    var puzzleSlideSFX: AVAudioPlayer?
    
    // Sound and music State Variable
    var musicIsOn = true
    var soundIsOn = true
    

    override func viewDidAppear(_ animated: Bool) {

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Creating a sound file for background music
        let homeMusicPath1 = Bundle.main.path(forResource: "Gameplay", ofType: "mp3")
        let homeMusicURL1 = NSURL.fileURL(withPath: homeMusicPath1!)

        // Creating a sound file for button sfx
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
    
        // If sound state that is sent from previous view is true
        // Then set the volume for the sfx to 5
        // Else mute the volume of the sfx
        if(soundIsOn == true){
            buttonPressedSFX?.volume = 5
        }
        else{
            buttonPressedSFX?.volume = 0
        }
        
        /* ==================================================================
         
            Idea to stop music background when user close the application
                                Thomas a, stackoverflow
           ================================================================ */

        // User notificationCenter and create Observer for when the app is closed and open
        // Then call the pauseSong or resumeSong function by passign the NSNotification
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector (pauseSong), name:NSNotification.Name.UIApplicationWillResignActive, object: nil)
        
        notificationCenter.addObserver(self, selector: #selector (resumeSong), name:NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
        
    }
    
    // Function to pause the song when user close the app
    func pauseSong(notification : NSNotification) {
        homeMusicPlayer1?.pause()
    }
    
    // Function to resume the song when user open the app
    func resumeSong(notification : NSNotification) {
        homeMusicPlayer1?.play()
        
    }
    
    // Function to stop the music
    func stopMusic(){
        homeMusicPlayer1?.stop()
    }
    
    // Function to play the music
    // - Allow the music to repeat always
    func playMusic(){
        homeMusicPlayer1?.play()
        homeMusicPlayer1?.numberOfLoops = -1
    }
    
    // Go back to the puzzle selection view controller
    @IBAction func playButtonPressed(_ sender: AnyObject) {
        buttonPressedSFX?.play()

    }
    
    // Function to mute and unmute sfx
    @IBAction func muteUnmuteSound(_ sender: AnyObject) {
        buttonPressedSFX?.play()
        
        // If pressed when sound state is on
        // Mute the sfx button, set volume to 0
        // Change the button image to be the most appropriate image
        // Set the sound state to be false
        if(soundIsOn == true){
            buttonPressedSFX?.play()
            soundFXButton.setImage(UIImage(named: "sound-off-music-on"), for: .normal)
            buttonPressedSFX?.volume = 0
            
            
            // music is on while the sound is on
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
            
        // Else if pressed when sound state is off
        // Unmute the sfx button, set volume to 5
        // Change the button image to be the most appropriate image
        // Set the sound state to be true
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
    
    // Function to play and stop music
    @IBAction func playStopMusic(_ sender: AnyObject) {
        buttonPressedSFX?.play()
        
        // If pressed when music state is on
        // Stop the music
        // Change the button image to be the most appropriate image
        // Set the music state to be false
        if(musicIsOn == true){
            buttonPressedSFX?.play()
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
            
        // If pressed when music state is off
        // Start the music
        // Change the button image to be the most appropriate image
        // Set the music state to be true
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
    
    
    // Function to show the about us view
    // - Set the center X contraint to be 0
    // - Hide background button
    @IBAction func openAboutUsView(_ sender: AnyObject) {
        
        buttonPressedSFX?.play()
        aboutUsCenterX.constant = 0
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
            self.backgroundButton.alpha = 0
        })
    }
    
    // Function to show the help view
    // - Set the center X contraint to be 0
    // - Hide background button
    @IBAction func openHelpView(_ sender: AnyObject) {
        
        buttonPressedSFX?.play()
        helpCenterX.constant = 0
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
            self.backgroundButton.alpha = 0
        })
    }
    
    // Function to show the license view
    // - Set the center X contraint to be 0
    // - Hide background button
    @IBAction func openLicenseView(_ sender: AnyObject) {
        
        buttonPressedSFX?.play()
        licenseCenterX.constant = 0
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
            self.backgroundButton.alpha = 0
        })
    }
    
    // Function to close the license view
    // - Set the center X contraint to be -500
    // - Show background button
    @IBAction func closeLicensePopup(_ sender: AnyObject) {
        buttonPressedSFX?.play()
        licenseCenterX.constant = -500
        UIView.animate(withDuration: 0.1, animations: {
            self.view.layoutIfNeeded()
            self.backgroundButton.alpha = 0.5
        })
    }
    
    // Function to close the help view
    // - Set the center X contraint to be -500
    // - Show background button
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
    // - Show background button
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
    
    // Function to close the about us view
    // - Set the center X contraint to be -500
    // - Show background button
    @IBAction func closeAboutUsPopup(_ sender: AnyObject) {
        buttonPressedSFX?.play()
        aboutUsCenterX.constant = -500
        UIView.animate(withDuration: 0.1, animations: {
            self.view.layoutIfNeeded()
            self.backgroundButton.alpha = 0.5
        })
    }
    
    
    // Action to dismiss the setting popup view
    // - Set the center X contraint to be -500
    // - Hide background button
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
    
    // Function to go from one segue to other
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Identify the segue identifier
        // - If it is toPuzzleSelection then:
        // - Set the destination view controller to puzzle selection view controller
        // - Set a value for the variables inside the puzzle selection view controller
        // - Send:
        // -- sound state
        if segue.identifier == "toPuzzleSelection" {
            let destVc = segue.destination as! PuzzleSelectionViewController
            destVc.soundIsOn = soundIsOn
        }
    }
    
    // Go back to Home Page Function
    @IBAction func exitToHomeScene(sender: UIStoryboardSegue){

    }
    
}
