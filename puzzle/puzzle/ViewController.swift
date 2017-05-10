//
//  ViewController.swift
//  puzzle
//
//  Created by Amritpal Singh on 29/4/17.
//  Copyright © 2017 Amritpal Singh. All rights reserved.

import UIKit
class ViewController: UIViewController {
<<<<<<< Updated upstream

=======
    
>>>>>>> Stashed changes
    var allImgViews = [UIView]()
    var allCenters = [Any]()
    var emptySpot = CGPoint.zero
    var tapCen = CGPoint.zero
    var left = CGPoint.zero
    var right = CGPoint.zero
    var top = CGPoint.zero
    var bottom = CGPoint.zero
    var leftIsEmpty: Bool = false
    var rightIsEmpty: Bool = false
    var topIsEmpty: Bool = false
    var bottomIsEmpty: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
<<<<<<< Updated upstream
        
        allImgViews = [UIView]()
        allCenters = [Any]()
=======
        allImgViews = [UIView]()
        allCenters = [CGPoint]()
>>>>>>> Stashed changes
        var xCen: Int = 49
        var yCen: Int = 200
        for v in 0..<4 {
            for h in 0..<4 {
<<<<<<< Updated upstream
                let myImgView = UIImageView(frame: CGRect(x: CGFloat(), y: CGFloat(192), width: CGFloat(98), height: CGFloat(94)))
                let curCen = CGPoint(x: CGFloat(xCen), y: CGFloat(yCen))
                allCenters.append(curCen)
                myImgView.center = curCen
=======
                let myImgView = UIImageView(frame: CGRect(x: 0, y: 192, width: 98, height: 94))
                let curCen = CGPoint(x: xCen, y: yCen)
                allCenters.append(curCen)
                myImgView.center = curCen
                //myImgView.backgroundColor = UIColor.red;
>>>>>>> Stashed changes
                myImgView.image = UIImage(named: String(format: "ai_%02i.jpg", h + v * 4))
                myImgView.isUserInteractionEnabled = true
                allImgViews.append(myImgView)
                view.addSubview(myImgView)
                xCen += 98
            }
            xCen = 49
            yCen += 94
        }
<<<<<<< Updated upstream
        allImgViews[0].removeFromSuperview()
        allImgViews.remove(at: 0)
=======
        //allImgViews[0].removeFromSuperview()
        //allImgViews.remove(at: 0)
>>>>>>> Stashed changes
        // we have an array with all 15 imageviews and another array with all 16 centers
        randomizeBlocks()
    }
    
    func randomizeBlocks() {
        var centersCopy: [Any] = allCenters
        var randLocInt: Int
        var randLoc: CGPoint
<<<<<<< Updated upstream
        for view in allImgViews {
            randLocInt = Int(arc4random()) % centersCopy.count
            randLoc = allCenters[randLocInt] as! CGPoint
            view.center = randLoc
=======
//        //for index in stride(from: 0, to: allImgViews.count, by: 1)  {
        for view in allImgViews {
            randLocInt = Int(arc4random_uniform(UInt32(centersCopy.count)))
            randLoc = centersCopy[randLocInt] as! CGPoint
            //let any = UIView()
            view.center = randLoc
            //any.center = randLoc
            //allImgViews[index] = any
            
>>>>>>> Stashed changes
            centersCopy.remove(at: randLocInt)

        }
<<<<<<< Updated upstream
        emptySpot = centersCopy[0] as! CGPoint
    }
    

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        <#code#>
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {

        let myTouch: UITouch? = (Array(touches)[0] as? UITouch)
        //var myTouch: UITouch! = Array(touches)[0] as UITouch
        if myTouch?.view != view {
        tapCen = myTouch?.view?.center
        left = CGPoint(x: CGFloat(tapCen.x - 192), y: CGFloat(tapCen.y))
        right = CGPoint(x: CGFloat(tapCen.x + 192), y: CGFloat(tapCen.y))
        top = CGPoint(x: CGFloat(tapCen.x), y: CGFloat(tapCen.y + 192))
        bottom = CGPoint(x: CGFloat(tapCen.x), y: CGFloat(tapCen.y - 192))
            
                    if NSValue(left).isEqual(NSValue(emptySpot)) {
                        leftIsEmpty = true
                    }
                    if NSValue(right).isEqual(NSValue(emptySpot)) {
                        rightIsEmpty = true
                    }
                    if NSValue(top).isEqual(NSValue(emptySpot)) {
                        topIsEmpty = true
                    }
                    if NSValue(bottom).isEqual(NSValue(emptySpot)) {
                        bottomIsEmpty = true
                    }
                    if leftIsEmpty || rightIsEmpty || bottomIsEmpty || topIsEmpty {
                        UIView.beginAnimations(nil, context: nil)
                        UIView.animationsDuration = 0.5
                        myTouch?.view?.center = emptySpot
                        UIView.commitAnimations()
                        emptySpot = tapCen
                        leftIsEmpty = false
                        rightIsEmpy = false
                        topIsEmpty = false
                        bottomIsEmpty = false
                    }
          }

    }
    
    //override func touchesEnded(_touches: Set<UITouch>, with event: UIEvent) {
        //let myTouch: UITouch? = (Array(touches)[0] as? UITouch)
        //if myTouch?.view != view {
            //tapCen = myTouch?.view?.center
            //left = CGPoint(x: CGFloat(tapCen.x - 192), y: CGFloat(tapCen.y))
            //right = CGPoint(x: CGFloat(tapCen.x + 192), y: CGFloat(tapCen.y))
            //top = CGPoint(x: CGFloat(tapCen.x), y: CGFloat(tapCen.y + 192))
            //bottom = CGPoint(x: CGFloat(tapCen.x), y: CGFloat(tapCen.y - 192))
            //if NSValue(left).isEqual(NSValue(emptySpot)) {
            //    leftIsEmpty = true
            //}
=======

        //emptySpot = centersCopy[0] as! CGPoint
    }
    
    func touchesEnded (touches: Set<UITouch>, withEvent event: UIEvent) {
 //       let myTouch: UITouch? = (touches[0] as? UITouch)
//        let myTouch: UITouch? = (Array(touches) as? UITouch)
//          if myTouch?.view != view {
//            tapCen = (myTouch?.view?.center)!
//            left = CGPoint(x: tapCen.x - 192, y: tapCen.y)
//            right = CGPoint(x: tapCen.x + 192, y: tapCen.y)
//            top = CGPoint(x: tapCen.x, y: tapCen.y + 192)
//            bottom = CGPoint(x: tapCen.x, y: tapCen.y - 192)
//            if NSValue(left).isEqual(NSValue(emptySpot)) {
//                leftIsEmpty = true
//            }
>>>>>>> Stashed changes
//            if NSValue(right).isEqual(NSValue(emptySpot)) {
//                rightIsEmpty = true
//            }
//            if NSValue(top).isEqual(NSValue(emptySpot)) {
//                topIsEmpty = true
//            }
//            if NSValue(bottom).isEqual(NSValue(emptySpot)) {
//                bottomIsEmpty = true
//            }
//            if leftIsEmpty || rightIsEmpty || bottomIsEmpty || topIsEmpty {
//                UIView.beginAnimations(nil, context: nil)
<<<<<<< Updated upstream
//                UIView.animationsDuration = 0.5
=======
//                //UIView.animationsDuration = 0.5
>>>>>>> Stashed changes
//                myTouch?.view?.center = emptySpot
//                UIView.commitAnimations()
//                emptySpot = tapCen
//                leftIsEmpty = false
<<<<<<< Updated upstream
//                rightIsEmpy = false
//                topIsEmpty = false
//                bottomIsEmpty = false
//            }
      //  }
    //}

 
    
//        let allImgViews = NSMutableArray()
//        let allCenters = NSMutableArray()
//        
//        var xCen: Int = 49;
//        var yCen: Int = 200;
//        
//        super.viewDidLoad()
//        
//        for v in stride(from: 0, to: 4, by: 1)
//        {
//            for h in stride(from: 0, to: 4, by: 1)
//            {
//                var imageView : UIImageView
//                imageView  = UIImageView(frame:CGRect(x:0, y:192, width:98, height:94));
//                let currentCenter = CGPoint(x: xCen,y: yCen);
//                allCenters.add(currentCenter)
//                imageView.center = currentCenter;
//                imageView.image = UIImage (named:String(format: "ai_%02i.jpg", h+v*4));
//                imageView.isUserInteractionEnabled = true;
//                allImgViews.add(imageView)
//                view.addSubview(imageView)
//                xCen += 98;
//            }
//            xCen = 49;
//            yCen += 94;
//        }
//
//} //delete
    
    override func didReceiveMemoryWarning(){
        super.didReceiveMemoryWarning()
=======
//                rightIsEmpty = false
//                topIsEmpty = false
//                bottomIsEmpty = false
//            }
//       }
    }
        
        /*let allImgViews = NSMutableArray()
        let allCenters = NSMutableArray()
        
        var xCen: Int = 49;
        var yCen: Int = 200;
        
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

}*/ //delete
override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
>>>>>>> Stashed changes
    }
}

