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
        self.motionManager.accelerometerUpdateInterval = 0.01
        self.motionManager.startAccelerometerUpdatesToQueue(NSOperationQueue.mainQueue()) {
            [weak self] (data: CMAccelerometerData!, error: NSError!) in
            self!.xValueLabel.text = self?.numberFormatter.stringFromNumber(self!.calibratedAcceleration.x + data.acceleration.x)
            self!.yValueLabel.text = self?.numberFormatter.stringFromNumber(self!.calibratedAcceleration.x + data.acceleration.y)
            self!.zValueLabel.text = self?.numberFormatter.stringFromNumber(self!.calibratedAcceleration.x + data.acceleration.z)
            
            if self?.functionalitySwitch.on != nil {
                self?.setBackgroundWithCalibration()
            } else if self?.view.backgroundColor != UIColor.whiteColor() {
                self?.view.backgroundColor = UIColor.whiteColor()
            }
        }
    }
    
    func setBackgroundWithCalibration() {
        self.view.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    // MARK: - Actions

    @IBAction func zeroButtonTapped(sender: AnyObject) {
        self.calibratedAcceleration.x = self.motionManager.accelerometerData.acceleration.x
        self.calibratedAcceleration.y = self.motionManager.accelerometerData.acceleration.y
        self.calibratedAcceleration.z = self.motionManager.accelerometerData.acceleration.z
        
        self.view.backgroundColor = UIColor.whiteColor()
    }
}
