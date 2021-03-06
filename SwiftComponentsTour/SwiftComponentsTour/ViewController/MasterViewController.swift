//
//  MasterViewController.swift
//  SwiftComponentsTour
//
//  Created by Kyle Roberts on 7/6/15.
//  Copyright (c) 2015 Kyle Roberts. All rights reserved.
//

import UIKit

class NIOMasterViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISplitViewControllerDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    var sections = [
        ["Labels (UILabel)",
            "Text Fields (UITextField)",
            "Text Views (UITextView)"],
        ["Buttons (UIButton)",
            "Switches (UISwitch)",
            "Sliders (UISlider)",
            "Segmented Controls (UISegmentedControl)",
            "Steppers (UIStepper)"],
        ["Progress and Activity",
            "Pickers",
            "Gestures",
            "Accelerometer"]
        ]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.preferredContentSize = CGSize(width: 320.0, height: 600.0)
        self.title = "Swift Components Tour"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.splitViewController!.delegate = self
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "NimbleNoggin.io.background")!)
        self.tableView.backgroundColor = UIColor.clearColor()
        self.tableView.registerClass(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: "Header")
        self.tableView.tableFooterView = UIView()
        
        self.navigationController!.navigationBar.barTintColor = UIColor(red:1, green:0.66, blue:0.18, alpha:1)
        self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        ((self.splitViewController!.viewControllers.last as! UINavigationController).viewControllers.first)!.title = self.sections[0][0]
    }

    // MARK: - Table View
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header: UITableViewHeaderFooterView? = tableView.dequeueReusableHeaderFooterViewWithIdentifier("Header")
        header?.contentView.backgroundColor = UIColor(red:0.58, green:0.78, blue:0.12, alpha:1)
        let label: UILabel = UILabel(frame: CGRectMake(10, 13, 0, 0))
        label.textColor = UIColor.whiteColor()
        label.font = label.font.fontWithSize(20)
        header?.contentView.addSubview(label)
        
        switch (section) {
        case 0:
            label.text = "Text Components"
        case 1:
            label.text = "Controls"
        case 2:
            label.text = "Advanced Interaction"
        default:
            label.text = ""
        }
        
        label.sizeToFit()
        
        return header
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = sections[section]
        return section.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) 
        
        cell.textLabel!.text = sections[indexPath.section][indexPath.row]
        cell.contentView.backgroundColor = UIColor.clearColor()
        cell.selectionStyle = UITableViewCellSelectionStyle.None

        return cell
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.backgroundColor = UIColor.clearColor()
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell:UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)!
        cell.contentView.backgroundColor = UIColor(red:0.58, green:0.78, blue:0.12, alpha:0.5)
        
        self.splitViewController?.collapseSecondaryViewController((self.splitViewController?.viewControllers.first!)!, forSplitViewController: self.splitViewController!)
        
        let controller: UIViewController? = storyboard?.instantiateViewControllerWithIdentifier(sections[indexPath.section][indexPath.row])
        (self.splitViewController!.viewControllers.last as! UINavigationController).setViewControllers([controller!], animated: true)
        controller!.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
        controller!.navigationItem.leftItemsSupplementBackButton = true
        controller!.title = self.sections[indexPath.section][indexPath.row]
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        let cell:UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)!
        cell.contentView.backgroundColor = UIColor.clearColor()
    }

}

