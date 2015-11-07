//
//  EditCardViewController.swift
//  FingTech
//
//  Created by fixd on 11/7/15.
//  Copyright © 2015 fixd. All rights reserved.
//

import UIKit

class EditCardViewController: UIViewController {
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var cardNumberField: UITextField!
    @IBOutlet weak var cvvField: UITextField!
    @IBOutlet weak var zipField: UITextField!
    @IBOutlet weak var monthStepper: UIStepper!
    @IBOutlet weak var yearStepper: UIStepper!
    
    @IBOutlet weak var expiresText: UILabel!
    
    var month:Int {
        get {
            return Int(monthStepper.value)
        }
    }
    
    var year:Int {
        get {
            return Int(yearStepper.value)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        monthStepper.value = Double(NSCalendar.currentCalendar().component(.Month, fromDate: NSDate()))
        monthStepper.maximumValue = 12
        monthStepper.minimumValue = 1
        monthStepper.wraps = true
        
        monthStepper.value = Double(NSCalendar.currentCalendar().component(.Year, fromDate: NSDate()))
        monthStepper.maximumValue = 9999
        monthStepper.minimumValue = 1
        monthStepper.wraps = true
    }
    
    @IBAction func StepperChanged(sender: UIStepper) {
        expiresText.text = "\(month) / \(year)"
    }
    
    @IBAction func submit(sender: UIButton) {
        
        let card = CreditCard()
        
        card.holderName = nameField.text!
        card.cardNumber = Int(cardNumberField.text!)!
        card.cvv = Int(cvvField.text!)!
        card.zipcode = Int(zipField.text!)!
        card.expireMonth = month
        card.expireYear = year
        
        print(card)
        
        //TODO store card
    }
}
