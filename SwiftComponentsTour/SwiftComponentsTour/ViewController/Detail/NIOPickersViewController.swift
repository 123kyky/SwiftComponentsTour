//
//  NIOPickersViewController.swift
//  SwiftComponentsTour
//
//  Created by Kyle Roberts on 7/6/15.
//  Copyright (c) 2015 nimblenoggin.io. All rights reserved.
//

import UIKit

class NIOPickersViewController: NIOBaseDetailViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var pickerDisplayLabel: UILabel!
    @IBOutlet weak var dateTextField: UITextField!
    
    var pickerData = ["Mountain View", "Sunnyvale", "Cupertino", "Santa Clara", "San Jose"]
    var dateFormatter = NSDateFormatter()
    var datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.setUpPicker()
        self.setUpDatePicker()
    }
    
    // MARK: - UIPickerView
    
    func setUpPicker() {
        self.picker.layer.borderColor = UIColor.blackColor().CGColor
        self.picker.layer.borderWidth = 2
        
        self.picker.dataSource = self
        self.picker.delegate = self
        
        self.picker.selectRow(2, inComponent: 0, animated: false)
        self.pickerDisplayLabel.text = self.pickerData[2]
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 5
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return self.pickerData[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.pickerDisplayLabel.text = self.pickerData[row]
    }
    
    // MARK: - UIDatePicker
    
    func setUpDatePicker() {
        self.datePicker.datePickerMode = .Date;
        self.datePicker.addTarget(self, action: Selector("datePickerDateChanged"), forControlEvents: .ValueChanged)
        self.datePicker.date = NSDate()
        self.datePicker.backgroundColor = UIColor.whiteColor()
        self.dateTextField.inputView = self.datePicker
        self.dateFormatter.dateStyle = .FullStyle
    }
        
    func datePickerDateChanged() {
        self.dateTextField.text = self.dateFormatter.stringFromDate(self.datePicker.date)
    }
    
    // MARK: - First Responder
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        super.touchesBegan(touches, withEvent: event)
        
        self.view.endEditing(true)
    }
}
