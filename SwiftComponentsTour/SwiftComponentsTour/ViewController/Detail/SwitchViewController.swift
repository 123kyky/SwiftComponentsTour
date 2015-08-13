//
//  SwitchViewController.swift
//  SwiftComponentsTour
//
//  Created by Kyle Roberts on 7/6/15.
//  Copyright (c) 2015 nimblenoggin.io. All rights reserved.
//

import UIKit

class NIOSwitchViewController: NIOBaseDetailViewController {

    @IBOutlet weak var spotlightSwitch: UISwitch!
    @IBOutlet weak var houseLightsSwitch: UIButton!
    @IBOutlet weak var lightsLabel: UILabel!
    
    @IBOutlet weak var leftSpotlight: UIImageView!
    @IBOutlet weak var leftSpotlightLeftConstraint: NSLayoutConstraint!
    @IBOutlet weak var rightSpotlight: UIImageView!
    @IBOutlet weak var rightSpotlightRightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.houseLightsSwitch.selected = false
        self.lightsLabel.layer.shadowOpacity = 1
        self.lightsLabel.layer.shadowRadius = 6
        self.lightsLabel.layer.shadowColor = UIColor.whiteColor().CGColor
        
        self.rightSpotlight.transform = CGAffineTransformMakeScale(-1, 1)
        self.leftSpotlightLeftConstraint.constant = -self.leftSpotlight.frame.size.width
        self.rightSpotlightRightConstraint.constant = -self.rightSpotlight.frame.size.width
    }
    
    // MARK: - Actions
    
    @IBAction func spotlightsToggled(sender: AnyObject) {
        if self.spotlightSwitch.on {
            self.turnOnSpotlights()
        } else {
            self.turnOffSpotlights()
        }
    }

    @IBAction func houseLightsToggled(sender: AnyObject) {
        if self.houseLightsSwitch.selected {
            self.houseLightsSwitch.selected = false
            self.turnOffHouseLights()
        } else {
            self.houseLightsSwitch.selected = true
            self.turnOnHouseLights()
        }
    }
    
    // MARK: - Animations
    
    func turnOnSpotlights() {
        if self.houseLightsSwitch.selected {
            self.houseLightsToggled(self)
        }
        
        self.leftSpotlightLeftConstraint.constant = 0
        self.rightSpotlightRightConstraint.constant = 0
        
        UIView .animateWithDuration(0.75, animations: { () -> Void in
            self.view.layoutIfNeeded()
        })
    }
    
    func turnOffSpotlights() {
        self.leftSpotlightLeftConstraint.constant = -self.leftSpotlight.frame.size.width
        self.rightSpotlightRightConstraint.constant = -self.rightSpotlight.frame.size.width
        
        UIView .animateWithDuration(0.75, animations: { () -> Void in
            self.view.layoutIfNeeded()
            self.spotlightSwitch.on = false
        })
    }
    
    func turnOnHouseLights() {
        self.turnOffSpotlights()
        UIView .animateWithDuration(0.75, animations: { () -> Void in
            self.view.backgroundColor = UIColor.whiteColor()
            self.lightsLabel.layer.shadowColor = UIColor.blackColor().CGColor
        })
    }
    
    func turnOffHouseLights() {
        UIView .animateWithDuration(0.75, animations: { () -> Void in
            self.view.backgroundColor = UIColor.blackColor()
            self.lightsLabel.layer.shadowColor = UIColor.whiteColor().CGColor
        })
    }

}
