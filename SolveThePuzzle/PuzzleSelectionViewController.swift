//
//  PuzzleSelectionViewController.swift
//  SolveThePuzzle
//
//  Created by Michael Hartanto on 5/13/17.
//  Copyright © 2017 Amritpal Singh. All rights reserved.
//

import UIKit

class PuzzleSelectionViewController: UIViewController {
    
    var pictureSelected = "default"
    var puzzlePiecesFormat = "default"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet var puzzleCollection: [UIButton]!
    
    @IBAction func openGameScene(_ sender: AnyObject) {
        
        switch(sender.tag){
        case 0:
            pictureSelected = "puzzle1"
            puzzlePiecesFormat = "sw_%02i.jpg"
            print(pictureSelected)
            
            performSegue(withIdentifier: "toGame", sender: self)
            
            break
        case 1:
            pictureSelected = "puzzle2"
            puzzlePiecesFormat = "fb_%02i.jpg"
            print(pictureSelected)
            
            performSegue(withIdentifier: "toGame", sender: self)
            break
            
        case 2:
            pictureSelected = "puzzle3"
            puzzlePiecesFormat = "yt_%02i.jpg"
            
            performSegue(withIdentifier: "toGame", sender: self)
            
            break
            
        case 3:
            pictureSelected = "tree"
            puzzlePiecesFormat = "tr_%02i.jpg"
            
            performSegue(withIdentifier: "toGame", sender: self)
            
            break
            
        case 4:
            pictureSelected = "app_image"
            
            performSegue(withIdentifier: "toGame", sender: self)
            
            break
            
        case 5:
            pictureSelected = "tree"
            
            performSegue(withIdentifier: "toGame", sender: self)
            
            break
            
        case 6:
            pictureSelected = "app_image"
            
            performSegue(withIdentifier: "toGame", sender: self)
            
            break
            
        case 7:
            pictureSelected = "tree"
            
            performSegue(withIdentifier: "toGame", sender: self)
            
            break
            
        case 8:
            pictureSelected = "app_image"
            
            performSegue(withIdentifier: "toGame", sender: self)
            
            break
            
        case 9:
            pictureSelected = "tree"
            
            performSegue(withIdentifier: "toGame", sender: self)
            
            break
            
        case 10:
            pictureSelected = "app_image"
            
            performSegue(withIdentifier: "toGame", sender: self)
            
            break
            
        case 11:
            pictureSelected = "tree"
            
            performSegue(withIdentifier: "toGame", sender: self)
            
            break
            
        default:
            break
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toGame" {
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

