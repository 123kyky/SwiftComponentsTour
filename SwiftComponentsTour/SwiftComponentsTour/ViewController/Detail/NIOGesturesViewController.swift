//
//  NIOGesturesViewController.swift
//  SwiftComponentsTour
//
//  Created by Kyle Roberts on 7/6/15.
//  Copyright (c) 2015 nimblenoggin.io. All rights reserved.
//

import UIKit

class NIOGesturesViewController: UIViewController {

    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var leftConstraint: NSLayoutConstraint!
    @IBOutlet weak var rightConstraint: NSLayoutConstraint!
    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!

    @IBOutlet weak var square: UIView!

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.calculateSquareConstraintsCentered()
    }
    
    // MARK: - Helpers
    
    func calculateSquareConstraintsCentered() {
        self.topConstraint.constant = self.view.bounds.size.height / 2 - self.heightConstraint.constant / 2
        self.bottomConstraint.constant = self.view.bounds.size.height - self.topConstraint.constant - self.heightConstraint.constant
        self.leftConstraint.constant = self.view.bounds.size.width / 2 - self.widthConstraint.constant / 2
        self.rightConstraint.constant = self.view.bounds.size.width - self.leftConstraint.constant - self.widthConstraint.constant
        
        self.square.layoutIfNeeded()
    }
    
    // MARK: - Actions
    
    @IBAction func longPressed(sender: AnyObject) {
        UIView.animateWithDuration(1.0, animations: { () -> Void in
            self.widthConstraint.constant = 100
            self.heightConstraint.constant = 100
            self.square.transform = CGAffineTransformMakeRotation(0)
            self.square.backgroundColor = UIColor.blueColor()
            self.calculateSquareConstraintsCentered()
        })
    }
    
    @IBAction func pinchedSquare(sender: UIPinchGestureRecognizer) {
        var difference = -(self.widthConstraint.constant - self.widthConstraint.constant * sender.scale) / 2
        self.widthConstraint.constant *= sender.scale
        self.heightConstraint.constant *= sender.scale
        self.topConstraint.constant -= difference
        self.bottomConstraint.constant = self.view.bounds.size.height - self.topConstraint.constant - self.heightConstraint.constant
        self.leftConstraint.constant -= difference
        self.rightConstraint.constant = self.view.bounds.size.width - self.leftConstraint.constant - self.widthConstraint.constant
        
        sender.scale = 1
        self.square.layoutIfNeeded()
    }
    
    @IBAction func pannedSquare(sender: UIPanGestureRecognizer) {
        var pointInView = sender.translationInView(self.view)
        self.topConstraint.constant += pointInView.y
        self.bottomConstraint.constant = self.view.bounds.size.height - self.topConstraint.constant - self.heightConstraint.constant
        self.leftConstraint.constant += pointInView.x
        self.rightConstraint.constant = self.view.bounds.size.width - self.leftConstraint.constant - self.widthConstraint.constant
        
        sender.setTranslation(CGPointZero, inView: self.view)
        self.square.layoutIfNeeded()
    }
    
    @IBAction func rotatedSquare(sender: UIRotationGestureRecognizer) {
        self.square.transform = CGAffineTransformMakeRotation(sender.rotation)
    }
    
    @IBAction func tappedSquare(sender: AnyObject) {
        var random1 = CGFloat(arc4random()) /  CGFloat(UInt32.max)
        var random2 = CGFloat(arc4random()) /  CGFloat(UInt32.max)
        var random3 = CGFloat(arc4random()) /  CGFloat(UInt32.max)
        self.square.backgroundColor = UIColor(red: random1, green: random2, blue: random3, alpha: 1)
    }
}
