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

    @IBOutlet weak var demoPuzzleImageView: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var userTimeLabel: UILabel!
    @IBOutlet weak var clickToStartButton: UIButton!
    @IBOutlet weak var logoImageView: UIImageView!
    var soundPlayer: AVAudioPlayer?
    
    /*
    @IBAction func click(_ sender: AnyObject) {
        
        print("A")
    }*/
    

    
    
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
    
    
    // changing view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let newViewController: PuzzleGameViewController = segue.destination as! PuzzleGameViewController
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func exitToHomeScene(sender: UIStoryboardSegue){
        
    }
    
    // override the unwind function
    override func unwind(for unwindSegue: UIStoryboardSegue, towardsViewController subsequentVC: UIViewController) {
        let segue = UnwindScaleSegue(identifier: unwindSegue.identifier, source: unwindSegue.source, destination: unwindSegue.destination)
        segue.perform()
    }
    

}

