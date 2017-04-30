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
    var allImgViews = [Any]()
    var allCenters = [Any]()
    var emptySpot = CGPoint.zero
    var tapCen = CGPoint.zero
    var `left` = CGPoint.zero
    var `right` = CGPoint.zero
    var top = CGPoint.zero
    var bottom = CGPoint.zero
    var leftIsEmpty: Bool = false
    var rightIsEmpty: Bool = false
    var topIsEmpty: Bool = false
    var bottomIsEmpty: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        allImgViews = [Any]()
        allCenters = [Any]()
        var xCen: Int = 96
        var yCen: Int = 96
        for v in 0..<4 {
            for h in 0..<4 {
                let myImgView = UIImageView(frame: CGRect(x: CGFloat(300), y: CGFloat(234), width: CGFloat(192), height: CGFloat(192)))
                let curCen = CGPoint(x: CGFloat(xCen), y: CGFloat(yCen))
                allCenters.append(NSValue(curCen))
                myImgView.center = curCen
                myImgView.image = UIImage(named: String(format: "jc_%02i.jpg", h + v * 4))
                myImgView.isUserInteractionEnabled = true
                allImgViews.append(myImgView)
                //myImgView.backgroundColor = [UIColor redColor];
                view.addSubview(myImgView)
                xCen += 192
            }
            xCen = 96
            yCen += 192
        }
        allImgViews[0]?.removeFromSuperview()
        allImgViews.remove(at: 0)
        // we have an array with all 15 imageviews and another array with all 16 centers
        randomizeBlocks()
    }
    
    func randomizeBlocks() {
        var centesCopy: [Any] = allCenters
        var randLocInt: Int
        var randLoc: CGPoint
        for any: UIView in allImgViews {
            randLocInt = arc4random() % centersCopy.count
            randLoc = allCenters[randLocInt].cgPoint()
            any.center = randLoc
            centersCopy.remove(at: randLocInt)
        }
        emptySpot = centersCopy[0].cgPoint()
    }
    
    func touchesEnded(_ touches: Set<AnyHashable>, withEvent event: UIEvent) {
        let myTouch: UITouch? = (Array(touches)[0] as? UITouch)
        if myTouch?.view != view {
            tapCen = myTouch?.view?.center
            `left` = CGPoint(x: CGFloat(tapCen.x - 192), y: CGFloat(tapCen.y))
            `right` = CGPoint(x: CGFloat(tapCen.x + 192), y: CGFloat(tapCen.y))
            top = CGPoint(x: CGFloat(tapCen.x), y: CGFloat(tapCen.y + 192))
            bottom = CGPoint(x: CGFloat(tapCen.x), y: CGFloat(tapCen.y - 192))
            if NSValue(`left`).isEqual(NSValue(emptySpot)) {
                leftIsEmpty = true
            }
            if NSValue(`right`).isEqual(NSValue(emptySpot)) {
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
}

