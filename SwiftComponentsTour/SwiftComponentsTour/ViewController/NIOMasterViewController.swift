//
//  NIOMasterViewController.swift
//  SwiftComponentsTour
//
//  Created by Kyle Roberts on 7/6/15.
//  Copyright (c) 2015 Kyle Roberts. All rights reserved.
//

import UIKit

class NIOMasterViewController: UITableViewController, UISplitViewControllerDelegate {
    var sections = [
        ["Labels",
            "Text Fields",
            "Text Views"],
        ["Buttons",
            "Switches",
            "Sliders",
            "Segmented Controls",
            "Steppers"],
        ["Progress and Activity",
            "Pickers",
            "Gestures",
            "Accelerometer"]
        ]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.clearsSelectionOnViewWillAppear = false
        self.preferredContentSize = CGSize(width: 320.0, height: 600.0)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional  setup after loading the view, typically from a nib.
        
        self.splitViewController!.delegate = self
    }

    // MARK: - Table View
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return sections.count
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let title: String?
        switch (section) {
        case 0:
            title = "Text Components"
        case 1:
            title = "Basic Interation"
        case 2:
            title = "Advanced Interaction"
        default:
            title = ""
        }
        
        return title
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = sections[section]
        return section.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
        
        cell.textLabel!.text = sections[indexPath.section][indexPath.row]

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.splitViewController?.collapseSecondaryViewController(self.splitViewController?.viewControllers.first as! UIViewController, forSplitViewController: self.splitViewController!)
        
        let controller: UIViewController? = storyboard?.instantiateViewControllerWithIdentifier(sections[indexPath.section][indexPath.row]) as? UIViewController
        (splitViewController!.viewControllers.last as! UINavigationController).setViewControllers([controller!], animated: true)
        controller!.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
        controller!.navigationItem.leftItemsSupplementBackButton = true
        controller!.title = sections[indexPath.section][indexPath.row]
    }

}

