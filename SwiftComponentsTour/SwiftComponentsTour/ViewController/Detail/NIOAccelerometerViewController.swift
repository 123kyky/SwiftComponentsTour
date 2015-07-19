//
//  NIOAccelerometerViewController.swift
//  SwiftComponentsTour
//
//  Created by Kyle Roberts on 7/6/15.
//  Copyright (c) 2015 nimblenoggin.io. All rights reserved.
//

import UIKit
import CoreMotion

class NIOAccelerometerViewController: UIViewController {

    @IBOutlet weak var xValueLabel: UILabel!
    @IBOutlet weak var yValueLabel: UILabel!
    @IBOutlet weak var zValueLabel: UILabel!
    @IBOutlet weak var functionalitySwitch: UISwitch!
    
    var motionManager = CMMotionManager()
    var numberFormatter = NSNumberFormatter()
    var calibratedAcceleration = CMAcceleration()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.numberFormatter.numberStyle = .DecimalStyle
        self.numberFormatter.maximumFractionDigits = 3
        
        if self.motionManager.accelerometerAvailable {
            self.setUpAccelerometerMonitoring()
        }
    }
    
    // MARK: - Helpers
    
    func setUpAccelerometerMonitoring() {
        
        if self.motionManager.deviceMotionAvailable {
            self.motionManager.deviceMotionUpdateInterval = 0.01
            self.motionManager.startDeviceMotionUpdatesToQueue(NSOperationQueue.mainQueue()) {
                [weak self] (data: CMDeviceMotion!, error: NSError!) in
                self!.xValueLabel.text = self?.numberFormatter.stringFromNumber(data.gravity.x - self!.calibratedAcceleration.x)
                self!.yValueLabel.text = self?.numberFormatter.stringFromNumber(data.gravity.y - self!.calibratedAcceleration.y)
                self!.zValueLabel.text = self?.numberFormatter.stringFromNumber(data.gravity.z - self!.calibratedAcceleration.z)
                
                if self?.functionalitySwitch.on == true {
                    self?.setBackgroundWithCalibration()
                } else if self?.view.backgroundColor != UIColor.whiteColor() {
                    self?.view.backgroundColor = UIColor.whiteColor()
                }
            }
        }
    }
    
    func setBackgroundWithCalibration() {
        UIView.animateWithDuration(self.motionManager.deviceMotionUpdateInterval, animations: { () -> Void in
            self.view.backgroundColor = UIColor(red: CGFloat(abs(self.motionManager.deviceMotion.gravity.x)), green: CGFloat(abs(self.motionManager.deviceMotion.gravity.y)), blue: CGFloat(abs(self.motionManager.deviceMotion.gravity.z)), alpha: 1)
        })
    }
    
    // MARK: - Actions

    @IBAction func zeroButtonTapped(sender: AnyObject) {
        self.calibratedAcceleration.x = self.motionManager.deviceMotion.gravity.x
        self.calibratedAcceleration.y = self.motionManager.deviceMotion.gravity.y
        self.calibratedAcceleration.z = self.motionManager.deviceMotion.gravity.z
        
        self.view.backgroundColor = UIColor.whiteColor()
    }
}
