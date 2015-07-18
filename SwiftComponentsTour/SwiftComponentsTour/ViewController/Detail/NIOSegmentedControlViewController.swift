//
//  NIOSegmentedControlViewController.swift
//  SwiftComponentsTour
//
//  Created by Kyle Roberts on 7/6/15.
//  Copyright (c) 2015 nimblenoggin.io. All rights reserved.
//

import UIKit

class NIOSegmentedControlViewController: UIViewController {

    @IBOutlet weak var baseSegmentedButton: UISegmentedControl!
    @IBOutlet weak var mixSegmentedButton: UISegmentedControl!
    @IBOutlet weak var mixingView: UIView!
    
    var colors = [UIColor.whiteColor(), UIColor.redColor(), UIColor.blueColor(), UIColor.yellowColor()]

    // MARK: - Actions
    
    @IBAction func baseSegmentDidChange(sender: AnyObject) {
        self.view.backgroundColor = colors[self.baseSegmentedButton.selectedSegmentIndex]
    }

    @IBAction func mixSegmentDidChange(sender: AnyObject) {
        self.mixingView.backgroundColor = self.colors[self.mixSegmentedButton.selectedSegmentIndex].colorWithAlphaComponent(0.5)
    }
}
