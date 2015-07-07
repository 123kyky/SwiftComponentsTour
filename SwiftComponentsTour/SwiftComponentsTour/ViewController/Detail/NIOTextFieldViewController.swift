//
//  NIOTextFieldViewController.swift
//  SwiftComponentsTour
//
//  Created by Kyle Roberts on 7/6/15.
//  Copyright (c) 2015 nimblenoggin.io. All rights reserved.
//

import UIKit

class NIOTextFieldViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var firstTextField: UITextField!
    @IBOutlet weak var secondTextField: UITextField!

    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    var timer: NSTimer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.startAnimatingLabel()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name:UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name:UIKeyboardWillHideNotification, object: nil);
    }
    
    
    // MARK: - Text Field
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if string == "" { // backspace
            return true
        }
        
        let characterSet = NSCharacterSet(charactersInString: "0123456789")
        for unichar in string.utf16 {
            if  characterSet.characterIsMember(unichar) {
                return true
            }
        }
        
        return false
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        return true
    }

    @IBAction func textFieldDidChange(sender: AnyObject) {
        let firstNumber = self.firstTextField.text.toInt()
        let secondNumber = self.secondTextField.text.toInt()
        
        if firstNumber != nil && secondNumber != nil {
            self.timer!.invalidate()
            self.statusLabel.text = "\(firstNumber! + secondNumber!)"
        } else {
            self.startAnimatingLabel()
        }
    }
    
    // MARK: - Animation
    
    var waitingStrings = ["Waiting", "Waiting.", "Waiting..", "Waiting..."]
    func animateLabel() {
        var i = 0
        for waitingString in waitingStrings {
            if self.statusLabel.text == waitingString {
                ++i
                if i == waitingStrings.count {
                    i = 0
                }
                
                self.statusLabel.text = waitingStrings[i]
                break
            }
        
            ++i
        }
    }
    
    func startAnimatingLabel() {
        self.statusLabel.text = waitingStrings.first
        self.timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("animateLabel"), userInfo: nil, repeats: true)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        var keyboardFrame: CGRect = (notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        
        self.bottomConstraint.constant = keyboardFrame.size.height + 20
        UIView.animateWithDuration(notification.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! Double, animations: { () -> Void in
            self.view.layoutIfNeeded()
        })
    }
    
    func keyboardWillHide(notification: NSNotification) {
        self.bottomConstraint.constant = 20
        UIView.animateWithDuration(notification.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! Double, animations: { () -> Void in
            self.view.layoutIfNeeded()
        })
    }
    
}
