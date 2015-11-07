//
//  CardsViewController.swift
//  FingTech
//
//  Created by fixd on 11/6/15.
//  Copyright © 2015 fixd. All rights reserved.
//

import UIKit

class CardsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet
    var tableView: UITableView!
    
    var items: [CreditCard] = [CreditCard(), CreditCard()]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell!
        cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "cell")
        
        let item = items[indexPath.row]
        
        cell.textLabel?.text = item.encodedNumber
        cell.detailTextLabel?.text = "Expires: \(item.expireDate)"
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("You selected cell \(indexPath.row)!")
        
        let card = items[indexPath.row]
        let amount = 15.00
        card.charge(amount) { (success:Bool) -> Void in
            if(success){
                UIAlertView(title: "Success", message: "Your card has been charged $\(amount).", delegate: nil, cancelButtonTitle: "Awesome!").show()
            }else{
                UIAlertView(title: "Failure", message: "There was a problem processing the payment. Your card has not been charged.", delegate: nil, cancelButtonTitle: "Dag, yo").show()
            }
        }
        //TODO edit
    }

}

