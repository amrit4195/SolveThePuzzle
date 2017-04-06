//
//  ViewController.swift
//  SolveThePuzzle
//
//  Created by Amritpal Singh on 4/4/17.
//  Copyright © 2017 Amritpal Singh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var demoPuzzleImageView: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var userTimeLabel: UILabel!
    @IBOutlet weak var clickToStartButton: UIButton!
    @IBOutlet weak var logoImageView: UIImageView!
    /*
    @IBAction func click(_ sender: AnyObject) {
        
        print("A")
    }*/
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set image for the demo puzzle
        demoPuzzleImageView.contentMode = .scaleAspectFit
        demoPuzzleImageView.image = #imageLiteral(resourceName: "app_image")
     
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

