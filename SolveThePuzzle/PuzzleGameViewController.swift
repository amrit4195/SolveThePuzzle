//
//  PuzzleGameViewController.swift
//  SolveThePuzzle
//
//  Created by Michael Hartanto on 4/6/17.
//  Copyright © 2017 Amritpal Singh. All rights reserved.
//

import UIKit
import Foundation

class PuzzleGameViewController: UIViewController {

    let allImgViews = NSMutableArray()
    let allCenters = NSMutableArray()

    @IBOutlet weak var backButton: UIButton!
    
    override func viewDidLoad() {
    
        let allImgViews = NSMutableArray()
        let allCenters = NSMutableArray()
        
        var xCen: Int = 49;
        var yCen: Int = 200;
        
        super.viewDidLoad()
        
        for v in stride(from: 0, to: 4, by: 1)
        {
            for h in stride(from: 0, to: 4, by: 1)
            {
                var imageView : UIImageView
                imageView  = UIImageView(frame:CGRect(x:0, y:192, width:98, height:94));
                let currentCenter = CGPoint(x: xCen,y: yCen);
                allCenters.add(currentCenter)
                imageView.center = currentCenter;
                imageView.image = UIImage (named:String(format: "ai_%02i.jpg", h+v*4));
                imageView.isUserInteractionEnabled = true;
                allImgViews.add(imageView)
                view.addSubview(imageView)
                xCen += 98;
            }
            xCen = 49;
            yCen += 94;
        }
        allImgViews.removeObject(at: 0)
        self.randomizeBlocks()
 
 
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    var emptySlot = CGPoint();
     func randomizeBlocks() {
        var centersCopy = NSMutableArray()
        //centersCopy = allCenters.mutableCopy() as! NSMutableArray
        var randLoc: Int = 0;
        for UIView in allImgViews
        {
            randLoc =  Int(arc4random()) % Int(centersCopy.count);
            randLoc = centersCopy.object(at: randLoc) as! Int
            //allImgViews = randLoc
            centersCopy.removeObject(at: randLoc)
        }
        emptySlot = centersCopy.object(at: 0) as! CGPoint

    }
    
    
    
    var tapCen = CGPoint();
    var left = CGPoint();
    var right = CGPoint();
    var top = CGPoint();
    var bottom = CGPoint();
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let myTouch = UITouch()
        if myTouch.view != self.view
        {
            tapCen = (myTouch.view?.center)!;
        }
    }
 
 
}

