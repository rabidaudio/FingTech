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
    
    var cards: [CreditCard] = CardSource.getCards()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cards.count
    
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //var cell = tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell!
        let cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "cell")

        let item = cards[indexPath.row]
        
        cell.textLabel?.text = item.encodedNumber
        cell.detailTextLabel?.text = "Expires: \(item.expireDate)"
            
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        print("You selected cell \(indexPath.row)!")
        performSegueWithIdentifier("Show Add/Edit Card", sender: tableView.cellForRowAtIndexPath(indexPath))
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            switch identifier {
                case "Show Add/Edit Card":
                    if let vc = segue.destinationViewController as? EditCardViewController {
                        if let cell = sender as? UITableViewCell {
                            let index = tableView.indexPathForCell(cell)!.row
                            vc.card = cards[index]
                            print("sending card \(index) to edit: \(cards[index])")
                        }else{
                            print("letting view create new card")
                        }
                    }
                default: break
            }
        }
    }

}

