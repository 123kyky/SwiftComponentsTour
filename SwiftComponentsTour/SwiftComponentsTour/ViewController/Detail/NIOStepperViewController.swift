//
//  NIOStepperViewController.swift
//  SwiftComponentsTour
//
//  Created by Kyle Roberts on 7/6/15.
//  Copyright (c) 2015 nimblenoggin.io. All rights reserved.
//

import UIKit

class NIOStepperViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var numberStepper: UIStepper!
    @IBOutlet weak var dateStepper: UIStepper!
    @IBOutlet weak var utilityStepper: UIStepper!
    
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var utilitySegmentedControl: UISegmentedControl!
    
    var dateFormatter = NSDateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.dateFormatter.dateStyle = .FullStyle
        self.dateLabel.text = self.dateFormatter.stringFromDate(NSDate())
        
        let calendar: NSCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        let components: NSDateComponents = calendar.components(.CalendarUnitDay, fromDate: NSDate())
        self.dateStepper.value = Double(components.day)
        
        self.numberStepper.maximumValue = DBL_MAX
        self.numberStepper.minimumValue = -DBL_MAX
        self.utilityStepper.value = Double(UIScreen.mainScreen().brightness)
    }
    
    // MARK: - Actions
    
    @IBAction func stepperChangedValue(sender: AnyObject) {
        if sender as! NSObject == self.numberStepper {
            self.adjustNumberValue()
        } else if sender as! NSObject == self.dateStepper {
            self.adjustDate()
        } else if sender as! NSObject == self.utilityStepper {
            self.adjustBrightness()
        }
    }
    
    @IBAction func numberTextFieldDidChange(sender: AnyObject) {
        self.numberStepper.value = (self.numberTextField.text as NSString).doubleValue
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
    
    // MARK: - Formatting and function
    
    func adjustNumberValue() {
        self.numberTextField.text = "\(Int(self.numberStepper!.value))"
    }
    
    func adjustDate() {
        let date = self.dateFormatter.dateFromString(self.dateLabel!.text!)
        var components: NSDateComponents = NSCalendar.currentCalendar().components(.CalendarUnitDay, fromDate: date!)
        
        var steppedDate: NSDate? = nil
        if components.day > Int(self.dateStepper.value) {
            steppedDate = NSCalendar.currentCalendar().dateByAddingUnit(.CalendarUnitDay, value: -1, toDate: date!, options: .SearchBackwards)
        } else {
            steppedDate = NSCalendar.currentCalendar().dateByAddingUnit(.CalendarUnitDay, value: 1, toDate: date!, options: nil)
        }

        components = NSCalendar.currentCalendar().components(.CalendarUnitDay, fromDate: steppedDate!)
        
        self.dateStepper.value = Double(components.day)
        self.dateLabel.text = self.dateFormatter.stringFromDate(steppedDate!)
    }
    
    func adjustBrightness() {
        UIScreen.mainScreen().brightness = CGFloat(self.utilityStepper.value)
    }

}
