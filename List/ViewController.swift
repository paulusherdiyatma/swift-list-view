//
//  ViewController.swift
//  List
//
//  Created by paulus herdiyatma on 4/5/16.
//  Copyright © 2016 paulus herdiyatma. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var data : NSMutableArray = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //create dummy data of list
        let iphone3g : NSMutableDictionary = ["imageUrl": "http://cdn2.gsmarena.com/vv/bigpic/apple-iphone3g.jpg","title":"iphone 3G", "launched":"June 2008"]
        let iphone3gs : NSMutableDictionary = ["imageUrl": "http://cdn2.gsmarena.com/vv/bigpic/apple-iphone-3gs-ofic.jpg","title":"iphone 3GS", "launched":"June 2009"]
        let iphone4 : NSMutableDictionary = ["imageUrl": "http://cdn2.gsmarena.com/vv/bigpic/apple-iphone-4-ofic-final.jpg","title":"iphone 4", "launched":"June 2010"]
        let iphone4s : NSMutableDictionary = ["imageUrl": "http://cdn2.gsmarena.com/vv/bigpic/apple-iphone-4s-new.jpg","title":"iphone 4s", "launched":"October 2011"]
        let iphone5 : NSMutableDictionary = ["imageUrl": "http://cdn2.gsmarena.com/vv/bigpic/apple-iphone-5-ofic.jpg","title":"iphone 5", "launched":"September 2012"]
        let iphone5c : NSMutableDictionary = ["imageUrl": "http://cdn2.gsmarena.com/vv/bigpic/apple-iphone-5c-new2.jpg","title":"iphone 5c", "launched":"September 2013"]
        let iphone5s : NSMutableDictionary = ["imageUrl": "http://cdn2.gsmarena.com/vv/bigpic/apple-iphone-5s-ofic.jpg","title":"iphone 5s", "launched":"September 2013"]
        let iphone6 : NSMutableDictionary = ["imageUrl": "http://cdn2.gsmarena.com/vv/bigpic/apple-iphone-6-4.jpg","title":"iphone 6", "launched":"September 2014"]
        let iphone6Plus : NSMutableDictionary = ["imageUrl": "http://cdn2.gsmarena.com/vv/bigpic/apple-iphone-6-plus2.jpg","title":"iphone 6 Plus", "launched":"September 2014"]
        let iphone6s : NSMutableDictionary = ["imageUrl": "http://cdn2.gsmarena.com/vv/bigpic/apple-iphone-6s1.jpg","title":"iphone 6s", "launched":"September 2015"]
        let iphone6sPlus : NSMutableDictionary = ["imageUrl": "http://cdn2.gsmarena.com/vv/bigpic/apple-iphone-6s-plus.jpg","title":"iphone 6s Plus", "launched":"September 2015"]
        let iphone6SE : NSMutableDictionary = ["imageUrl": "http://cdn2.gsmarena.com/vv/bigpic/apple-iphone-5se-ofic.jpg","title":"iphone 6 SE", "launched":"March 2016"]
        
        self.data = [ iphone3g, iphone3gs, iphone4, iphone4s, iphone5, iphone5c, iphone5s, iphone6, iphone6Plus, iphone6s, iphone6sPlus, iphone6SE]
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
        return self.data.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //add border to the table view
        tableView.layer.borderWidth = 2
        tableView.layer.borderColor = UIColor.grayColor().CGColor

        //register ListCell to the table view
        let nibName = UINib(nibName: "listCell", bundle:nil)
        tableView.registerNib(nibName, forCellReuseIdentifier: "ListCell")
        let cell = tableView.dequeueReusableCellWithIdentifier("ListCell", forIndexPath: indexPath) as! ListCell
        
        //get and set data based on index
        let dataItem = self.data[indexPath.row]
        cell.title.text = (dataItem.valueForKey("title") as! String)
        cell.listDescription.text = (dataItem.valueForKey("launched") as! String)
        let urlString = dataItem.valueForKey("imageUrl") as! String
        let url = NSURL(string: urlString)
        
        //call download image function
        downloadImage(url!, cell: cell)
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //get current data from the selected index
        let selectedData = self.data[indexPath.row]
        let title = selectedData.valueForKey("title") as! String
        //define alert
        let alert: UIAlertController = UIAlertController(title: "Selected Phone", message: "you have selected "+title, preferredStyle: UIAlertControllerStyle.Alert)
        //define OK action
        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        //add action
        alert.addAction(defaultAction)
        //show the alert
        presentViewController(alert, animated: true, completion: nil)
    }
    
    //function to set image view from downloaded image data
    func downloadImage(url: NSURL, cell:ListCell){
        getDataFromUrl(url) { (data, response, error)  in
            dispatch_async(dispatch_get_main_queue()) { () -> Void in
                guard let data = data where error == nil else { return }
                cell.listImageView.image = UIImage(data: data)
            }
        }
    }
    
    //function to get image data from the url
    func getDataFromUrl(url:NSURL, completion: ((data: NSData?, response: NSURLResponse?, error: NSError? ) -> Void)) {
        NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in
            completion(data: data, response: response, error: error)
            }.resume()
    }
   

}

