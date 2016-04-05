//
//  ViewController.swift
//  List
//
//  Created by paulus herdiyatma on 4/5/16.
//  Copyright © 2016 paulus herdiyatma. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60.0
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "ListCell"
        tableView.layer.borderWidth = 2
        tableView.layer.borderColor = UIColor.grayColor().CGColor
        let nibName = UINib(nibName: "listCell", bundle:nil)
        tableView.registerNib(nibName, forCellReuseIdentifier: "ListCell")
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! ListCell
        cell.title.text = "Name" + String(indexPath.row+1)
        cell.listDescription.text = "Mr"
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let alert: UIAlertView = UIAlertView(title: "Selected Row", message: "You have selected row number "+String(indexPath.row+1), delegate: nil,  cancelButtonTitle: "Cancel");
        alert.show()
    }
   

}

