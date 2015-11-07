//
//  CardsViewController.swift
//  FingTech
//
//  Created by fixd on 11/6/15.
//  Copyright © 2015 fixd. All rights reserved.
//

import UIKit

class CardsViewController: UITableViewController {
    
    var items: [CreditCard] = [CreditCard(), CreditCard()]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell!
        cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "cell")
        
        let item = items[indexPath.row]
        
        cell.textLabel?.text = item.encodedNumber
        cell.detailTextLabel?.text = "Expires: \(item.expireDate)"
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("You selected cell \(indexPath.row)!")
        
        //TODO edit
    }

}

