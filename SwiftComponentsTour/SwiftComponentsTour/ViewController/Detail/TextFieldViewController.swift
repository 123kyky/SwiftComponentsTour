//
//  TextFieldViewController.swift
//  SwiftComponentsTour
//
//  Created by Kyle Roberts on 7/6/15.
//  Copyright (c) 2015 nimblenoggin.io. All rights reserved.
//

import UIKit

class NIOTextFieldViewController: NIOBaseDetailViewController, UITextFieldDelegate {

    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var firstTextField: UITextField!
    @IBOutlet weak var secondTextField: UITextField!

    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    var timer: NSTimer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.startAnimatingLabel()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(NIOTextFieldViewController.keyboardWillShow(_:)), name:UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(NIOTextFieldViewController.keyboardWillHide(_:)), name:UIKeyboardWillHideNotification, object: nil);
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
        let firstNumber = Int(self.firstTextField.text!)
        let secondNumber = Int(self.secondTextField.text!)
        
        if firstNumber != nil && secondNumber != nil {
            self.timer!.invalidate()
            self.statusLabel.text = "\(firstNumber! + secondNumber!)"
        } else {
            self.timer!.invalidate()
            self.startAnimatingLabel()
        }
    }
    
    // MARK: - Animation
    
    var waitingStrings = ["Waiting", "Waiting.", "Waiting..", "Waiting..."]
    func animateLabel() {
        var i = 0
        for waitingString in waitingStrings {
            if self.statusLabel.text == waitingString {
                i += 1
                if i == waitingStrings.count {
                    i = 0
                }
                
                self.statusLabel.text = waitingStrings[i]
                break
            }
        
            i += 1
        }
    }
    
    func startAnimatingLabel() {
        self.statusLabel.text = waitingStrings.first
        self.timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(NIOTextFieldViewController.animateLabel), userInfo: nil, repeats: true)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        let keyboardFrame: CGRect = (notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        
        self.bottomConstraint.constant = keyboardFrame.size.height + 20
        UIView.animateWithDuration(notification.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! Double, animations: { () -> Void in
            self.view.layoutIfNeeded()
        })
    }
    
    func keyboardWillHide(notification: NSNotification) {
        self.bottomConstraint.constant = 115
        UIView.animateWithDuration(notification.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! Double, animations: { () -> Void in
            self.view.layoutIfNeeded()
        })
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        
        self.view.endEditing(true)
    }
    
}
