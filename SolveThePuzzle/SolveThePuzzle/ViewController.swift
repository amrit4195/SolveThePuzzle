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
    //@IBOutlet weak var test: UILabel!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var userTimeLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var clickToStartButton: UIButton!

    // Outlets for the setting popup view
    @IBOutlet weak var closeSettingViewButton: UIButton!
    @IBOutlet weak var backgroundButton: UIButton!
    @IBOutlet weak var centerXPopupConstraint: NSLayoutConstraint!
    @IBOutlet weak var settingPopupView: UIView!
    
    // @IBOutlet weak var demoPuzzleImageView: UIImageView!

    @IBOutlet weak var soundFxButton: UIButton!
    @IBOutlet weak var musicButton: UIButton!
    @IBOutlet weak var aboutUsButton: UIButton!
    @IBOutlet weak var licenseButton: UIButton!
    
    
    // Initializing Variables
    var homeMusicPlayer1: AVAudioPlayer?
    var buttonPressedSFX: AVAudioPlayer?

    var musicIsOn = true
    var soundIsOn = true
  
    override func viewDidAppear(_ animated: Bool) {
//        let time : String? = UserDefaults.standard.object(forKey: "time") as? String
//        
//        if let timeToDisplay = time {
//            userTimeLabel.text = timeToDisplay
        

       // }

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
            soundFxButton.setImage(UIImage(named: "sound-off1-music-on1"), for: .normal)
            buttonPressedSFX?.volume = 0
            
            
            // music on but sound is on
            if(musicIsOn == true){
                musicButton.setImage(UIImage(named: "music-on1-sound-off1"), for: .normal)
                print("ee","musicIsOn:",musicIsOn,"soundIsOn:",soundIsOn)
                
            }else{
                musicButton.setImage(UIImage(named: "music-off-sound-off"), for: .normal)
                print("ff","musicIsOn:",musicIsOn,"soundIsOn:",soundIsOn)
                
            }
            soundIsOn = false
            
        }
        else if(soundIsOn == false){
            print("sound playing")
            soundFxButton.setImage(UIImage(named: "sound-on-music-on"), for: .normal)
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
                soundFxButton.setImage(UIImage(named: "sound-on-music-off"), for: .normal)
                print("aa","musicIsOn:",musicIsOn,"soundIsOn:",soundIsOn)
                
            }else{
                soundFxButton.setImage(UIImage(named: "sound-off-music-off"), for: .normal)
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
                soundFxButton.setImage(UIImage(named: "sound-on-music-on"), for: .normal)
                print("cc","musicIsOn:",musicIsOn,"soundIsOn:",soundIsOn)
                
            }else{
                soundFxButton.setImage(UIImage(named: "sound-off1-music-on1"), for: .normal)
                print("dd","musicIsOn:",musicIsOn,"soundIsOn:",soundIsOn)
                
            }
            musicIsOn = true
        }
 
        
        
//        if (homeMusicPlayer1?.isPlaying)! {
//            homeMusicPlayer1?.stop()
//        } else {
//            self.homeMusicPlayer1?.play()
//        }
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
        //UserDefaults.standard.set(test.text, forKey: "time")
    }
    // Go back to Home Page
    @IBAction func exitToHomeScene(sender: UIStoryboardSegue){
        
    }
    
    // Override the unwind function
    override func unwind(for unwindSegue: UIStoryboardSegue, towardsViewController subsequentVC: UIViewController) {
        let segue = UnwindScaleSegue(identifier: unwindSegue.identifier, source: unwindSegue.source, destination: unwindSegue.destination)
        segue.perform()
    }

}
// set image for the demo puzzle
//demoPuzzleImageView.contentMode = .scaleAspectFit
//demoPuzzleImageView.image = #imageLiteral(resourceName: "app_image")

/*
 // blinking animation
 UIView.animate(withDuration: 1, delay: 0.0, options: [.repeat,.autoreverse,.allowUserInteraction], animations: {
 self.clickToStartButton.alpha = 0.1 //disappear
 self.clickToStartButton.alpha = 1.0 // appear
 }, completion: nil)
 
 */

