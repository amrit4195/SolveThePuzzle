//
//  ViewController.swift
//  puzzle
//
//  Created by Amritpal Singh on 29/4/17.
//  Copyright © 2017 Amritpal Singh. All rights reserved.
//

//  Converted with Swiftify v1.0.6326 - https://objectivec2swift.com/
import UIKit
class ViewController: UIViewController {

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
        
        allImgViews = [UIView]()
        allCenters = [Any]()
        var xCen: Int = 49
        var yCen: Int = 200
        for v in 0..<4 {
            for h in 0..<4 {
                let myImgView = UIImageView(frame: CGRect(x: CGFloat(), y: CGFloat(192), width: CGFloat(98), height: CGFloat(94)))
                let curCen = CGPoint(x: CGFloat(xCen), y: CGFloat(yCen))
                allCenters.append(curCen)
                myImgView.center = curCen
                myImgView.image = UIImage(named: String(format: "ai_%02i.jpg", h + v * 4))
                myImgView.isUserInteractionEnabled = true
                allImgViews.append(myImgView)
                view.addSubview(myImgView)
                xCen += 98
            }
            xCen = 49
            yCen += 94
        }
        allImgViews[0].removeFromSuperview()
        allImgViews.remove(at: 0)
        // we have an array with all 15 imageviews and another array with all 16 centers
        randomizeBlocks()
    }
    
    func randomizeBlocks() {
        var centersCopy: [Any] = allCenters
        var randLocInt: Int
        var randLoc: CGPoint
        for view in allImgViews {
            randLocInt = Int(arc4random()) % centersCopy.count
            randLoc = allCenters[randLocInt] as! CGPoint
            view.center = randLoc
            centersCopy.remove(at: randLocInt)
        }
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
//                UIView.animationsDuration = 0.5
//                myTouch?.view?.center = emptySpot
//                UIView.commitAnimations()
//                emptySpot = tapCen
//                leftIsEmpty = false
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
    }
}

