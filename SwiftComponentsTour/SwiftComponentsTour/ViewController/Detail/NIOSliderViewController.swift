//
//  NIOSliderViewController.swift
//  SwiftComponentsTour
//
//  Created by Kyle Roberts on 7/6/15.
//  Copyright (c) 2015 nimblenoggin.io. All rights reserved.
//

import UIKit

class NIOSliderViewController: NIOBaseDetailViewController {
    
    @IBOutlet weak var spotlightsSlider: UISlider!
    @IBOutlet weak var houseLightsSlider: UISlider!
    @IBOutlet weak var lightsLabel: UILabel!
    @IBOutlet weak var houseLightsLabel: UILabel!
    
    @IBOutlet weak var leftSpotlight: UIImageView!
    @IBOutlet weak var leftSpotlightLeftConstraint: NSLayoutConstraint!
    @IBOutlet weak var rightSpotlight: UIImageView!
    @IBOutlet weak var rightSpotlightRightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.lightsLabel.layer.shadowOpacity = 1
        self.lightsLabel.layer.shadowRadius = 6
        self.lightsLabel.layer.shadowColor = UIColor.whiteColor().CGColor
        self.houseLightsLabel.layer.shadowOpacity = 1
        self.houseLightsLabel.layer.shadowRadius = 6
        self.houseLightsLabel.layer.shadowColor = UIColor.whiteColor().CGColor
        
        self.rightSpotlight.transform = CGAffineTransformMakeScale(-1, 1)
        self.leftSpotlightLeftConstraint.constant = -self.leftSpotlight.frame.size.width
        self.rightSpotlightRightConstraint.constant = -self.rightSpotlight.frame.size.width
    }
    
    // MARK: - Actions
    
    @IBAction func spotlightsSliderDidChange(sender: AnyObject) {
        self.setSpotlightsTo(CGFloat(1 - self.spotlightsSlider.value))
    }
    
    @IBAction func houseLightsSliderDidChange(sender: AnyObject) {
        self.setHouseLightsTo(CGFloat(self.houseLightsSlider.value))
    }
    
    // MARK: - Animations
    
    func setSpotlightsTo(percent: CGFloat) {
        self.leftSpotlightLeftConstraint.constant = -(self.leftSpotlight.frame.size.width * percent)
        self.rightSpotlightRightConstraint.constant = -(self.rightSpotlight.frame.size.width * percent)
        
        self.view.layoutIfNeeded()
    }
    
    func setHouseLightsTo(percent: CGFloat) {
        let shadowPercentage = 1 - percent
        
        self.view.backgroundColor = UIColor(red: percent, green: percent, blue: percent, alpha: 1)
        self.lightsLabel.layer.shadowColor = UIColor(red: shadowPercentage, green: shadowPercentage, blue: shadowPercentage, alpha: 1).CGColor
        self.houseLightsLabel.layer.shadowColor = UIColor(red: shadowPercentage, green: shadowPercentage, blue: shadowPercentage, alpha: 1).CGColor
    }
    
}
