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
    @IBOutlet weak var userTimeLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var clickToStartButton: UIButton!

    // Outlets for the help popup view
    @IBOutlet weak var closeHelpViewButton: UIButton!
    @IBOutlet weak var backgroundButton: UIButton!
    @IBOutlet weak var centerXPopupConstraint: NSLayoutConstraint!
    @IBOutlet weak var helpPopupView: UIView!
    
    // @IBOutlet weak var demoPuzzleImageView: UIImageView!
    
    // Initializing Variables
    var soundPlayer: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create a sound file
        let path = Bundle.main.path(forResource: "LittleIdea", ofType: "mp3")
        let url = NSURL.fileURL(withPath: path!) // path cannot be nil
        
        // Inserting the sound file to the sound player variable
        
       
        do{
            try soundPlayer = AVAudioPlayer(contentsOf: url)
            
            soundPlayer?.play()
        }
            // Catch an error if the playback has an issue
        catch{print("Player does not work for some reason")}
        
        // Set up the help popup view design
        helpPopupView.layer.cornerRadius = 20
        helpPopupView.layer.masksToBounds = true
    
        
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
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        /*
        // blinking animation
        UIView.animate(withDuration: 1, delay: 0.0, options: [.repeat,.autoreverse,.allowUserInteraction], animations: {
            self.clickToStartButton.alpha = 0.1 //disappear
            self.clickToStartButton.alpha = 1.0 // appear
            }, completion: nil)
        */
    }
    
    @IBAction func playPauseSound(_ sender: AnyObject) {
        if (soundPlayer?.isPlaying)! {
            soundPlayer?.stop()
        } else {
            self.soundPlayer?.play()
        }
    }
    
    // Action to show the help popup view
    // - Show view by setting the X contraint to be 0
    // - Start Sliding Animation
    @IBAction func showHelpPopup(_ sender: AnyObject) {
        
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
    
    // Action to dismiss the help popup view
    @IBAction func closeHelpPopup(_ sender: AnyObject) {
        centerXPopupConstraint.constant =  -500
        
        // Slide Out Animation
        // - Layout the subview immediately
        // - Set background button alpha back to 0 (Unviewable and untouchable)
        UIView.animate(withDuration: 0.1, animations: {
            self.view.layoutIfNeeded()
            self.backgroundButton.alpha = 0
        })

    }
    
    // Open the puzzle Game View Controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let newViewController: PuzzleGameViewController = segue.destination as! PuzzleGameViewController
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

