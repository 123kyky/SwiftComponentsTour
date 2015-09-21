//
//  TextViewViewController.swift
//  SwiftComponentsTour
//
//  Created by Kyle Roberts on 7/6/15.
//  Copyright (c) 2015 nimblenoggin.io. All rights reserved.
//

import UIKit

class NIOTextViewViewController: NIOBaseDetailViewController, UITextViewDelegate {
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name:UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name:UIKeyboardWillHideNotification, object: nil);
    }
    
    // MARK: - Keyboard
    
    func keyboardWillShow(notification: NSNotification) {
        let keyboardFrame: CGRect = (notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        
        self.bottomConstraint.constant = keyboardFrame.size.height
        UIView.animateWithDuration(notification.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! Double, animations: { () -> Void in
            self.view.layoutIfNeeded()
        })
    }
    
    func keyboardWillHide(notification: NSNotification) {
        self.bottomConstraint.constant = 0
        UIView.animateWithDuration(notification.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! Double, animations: { () -> Void in
            self.view.layoutIfNeeded()
        })
    }
    
}


