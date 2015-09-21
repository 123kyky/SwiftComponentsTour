//
//  LabelViewController.swift
//  SwiftComponentsTour
//
//  Created by Kyle Roberts on 7/6/15.
//  Copyright (c) 2015 nimblenoggin.io. All rights reserved.
//

import UIKit

class NIOLabelViewController: NIOBaseDetailViewController {

    @IBOutlet weak var attributedLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setAttributedStrings()
    }
    
    // MARK: - Label
    
    func setAttributedStrings() {
        let font: UIFont = UIFont(name: "Georgia", size: 24)!
        let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: self.attributedLabel.text!)
        attributedString.addAttributes([NSStrikethroughStyleAttributeName : 2], range: NSMakeRange(7, 4))
        attributedString.addAttributes([NSFontAttributeName : font], range: NSMakeRange(12, 7))
        attributedString.addAttributes([NSForegroundColorAttributeName : UIColor.redColor()], range: NSMakeRange(20, 4))
        attributedString.addAttributes([NSObliquenessAttributeName : 0.5], range: NSMakeRange(25, 4))
        attributedLabel.attributedText = attributedString
    }

}
