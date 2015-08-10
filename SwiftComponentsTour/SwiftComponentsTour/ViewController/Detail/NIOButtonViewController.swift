//
//  NIOButtonViewController.swift
//  SwiftComponentsTour
//
//  Created by Kyle Roberts on 7/6/15.
//  Copyright (c) 2015 nimblenoggin.io. All rights reserved.
//

import UIKit

class NIOButtonViewController: NIOBaseDetailViewController {
    @IBOutlet var buttonBackgrounds: [UIView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for view in self.buttonBackgrounds {
            view.layer.borderColor = UIColor.whiteColor().CGColor
            view.layer.borderWidth = 2
            view.layer.cornerRadius = 5
        }
    }

    // MARK: - Actions
    
    @IBAction func randomizeBackgroundColor(sender: AnyObject) {
        self.view.backgroundColor = UIColor(red: CGFloat(Float(arc4random()) / Float(UINT32_MAX)), green: CGFloat(Float(arc4random()) / Float(UINT32_MAX)), blue: CGFloat(Float(arc4random()) / Float(UINT32_MAX)), alpha: 1)
    }
    
    @IBAction func addBackgroundImage(sender: AnyObject) {
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "NimbleNoggin.io.background")!)
    }
    
    @IBAction func changeTitle(sender: AnyObject) {
        if self.title == "Buttons" {
            self.title = "Butts"
        } else {
            self.title = "Buttons"
        }
    }
    
}
