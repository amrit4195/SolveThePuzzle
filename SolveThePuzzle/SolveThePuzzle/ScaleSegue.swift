//
//  ScaleSegue.swift
//  SolveThePuzzle
//
//  Created by Michael Hartanto on 4/6/17.
//  Copyright © 2017 Amritpal Singh. All rights reserved.
//


// https://www.youtube.com/watch?v=jn-93qElOT4 

import UIKit

class ScaleSegue: UIStoryboardSegue {
    
    override func perform() {
        scale()
    }

    func scale(){
        
        // Create two constant
        let toViewController = self.destination
        let fromViewController = self.source
        
        // create a container to add the toViewController
        let containerView = fromViewController.view.superview
        let originalCenter = fromViewController.view.center
        
        // adjusting the transform property using CFAffineTransform
        toViewController.view.transform = CGAffineTransform(scaleX: 0.05, y: 0.05) // scale down
        toViewController.view.center = originalCenter
        
        // adding subview
        containerView?.addSubview(toViewController.view)
        
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseInOut, animations: {
            
            toViewController.view.transform = CGAffineTransform.identity //zooming it back to its original size
            
            }, completion: { success in fromViewController.present(toViewController, animated: false, completion: nil) // present
        
        })
        
    }
    
}

class UnwindScaleSegue:UIStoryboardSegue {
    
    override func perform() {
        scale()
    }
    
    func scale () {
        let toViewController = self.destination
        let fromViewController = self.source
        
        fromViewController.view.superview?.insertSubview(toViewController.view, at: 0)
        
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
            fromViewController.view.transform = CGAffineTransform(scaleX: 0.05, y: 0.05) // scale it down
            }, completion: { success in
                fromViewController.dismiss(animated: false, completion: nil) // change to dismiss
        })
        
        
        
    }
    
    
}




