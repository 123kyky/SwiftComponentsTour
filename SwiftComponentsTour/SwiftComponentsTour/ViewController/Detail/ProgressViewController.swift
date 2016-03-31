//
//  ProgressViewController.swift
//  SwiftComponentsTour
//
//  Created by Kyle Roberts on 7/6/15.
//  Copyright (c) 2015 nimblenoggin.io. All rights reserved.
//

import UIKit

class NIOProgressViewController: NIOBaseDetailViewController {

    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var progressBar: UIProgressView!
    
    var isLoading = false
    var timer: NSTimer!
    
    // MARK: - Actions
    
    @IBAction func buttonTapped(sender: AnyObject) {
        if !self.isLoading {
            self.activityIndicator.startAnimating()
            self.startProgress()
            self.startButton.setTitle("Stop", forState: .Normal)
        } else {
            self.activityIndicator.stopAnimating()
            self.stopProgress()
        }
    }
    
    // MARK: - Helpers
    
    func startProgress() {
        if self.progressBar.progress == 1 {
            self.progressBar.progress = 0
        }
        
        self.isLoading = true
        self.timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: #selector(NIOProgressViewController.incrementProgressBar), userInfo: nil, repeats: true)
    }
    
    func incrementProgressBar() {
        self.progressBar.progress += 0.001
        if (self.progressBar.progress == 1) {
            self.activityIndicator.stopAnimating()
            self.stopProgress()
        }
    }
    
    func stopProgress() {
        self.timer.invalidate()
        self.isLoading = false
        if self.progressBar.progress == 1 {
            self.startButton.setTitle("Start", forState: .Normal)
        } else {
            self.startButton.setTitle("Continue", forState: .Normal)
        }
    }
}
