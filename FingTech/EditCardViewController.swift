//
//  EditCardViewController.swift
//  FingTech
//
//  Created by fixd on 11/7/15.
//  Copyright © 2015 fixd. All rights reserved.
//

import UIKit
import SwiftValidator

class EditCardViewController: UIViewController, UITextFieldDelegate, ValidationDelegate {
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var cardNumberField: UITextField!
    @IBOutlet weak var cvvField: UITextField!
    @IBOutlet weak var zipField: UITextField!
    @IBOutlet weak var monthStepper: UIStepper!
    @IBOutlet weak var yearStepper: UIStepper!
    
    @IBOutlet weak var expiresText: UILabel!
    
    let validator = Validator()
    
    var textFields:[UITextField] {
        get {
            return [nameField, cardNumberField, cvvField, zipField]
        }
    }
    
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
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "hideKeyboard"))

        textFields.forEach({$0.delegate = self })
        
        validator.registerField(nameField, rules: [RequiredRule()])
        validator.registerField(cardNumberField, rules: [RequiredRule(), FloatRule(), MinLengthRule(length: 16), MaxLengthRule(length: 16)])
        validator.registerField(cvvField, rules: [RequiredRule(), FloatRule(), MinLengthRule(length: 3), MaxLengthRule(length: 4)])
        validator.registerField(zipField, rules: [RequiredRule(), ZipCodeRule()])
        
        monthStepper.value = Double(NSCalendar.currentCalendar().component(.Month, fromDate: NSDate()))
        monthStepper.maximumValue = 12
        monthStepper.minimumValue = 1
        monthStepper.wraps = true
        
        yearStepper.value = Double(NSCalendar.currentCalendar().component(.Year, fromDate: NSDate()))
        yearStepper.maximumValue = 9999
        yearStepper.minimumValue = 1
        yearStepper.wraps = true
        
        stepperChanged(monthStepper)
    }
    
    @IBAction func stepperChanged(sender: UIStepper) {
        expiresText.text = String(format: "%02d / %04d", month, year)
    }
    
    @IBAction func submit(sender: UIButton) {
        validator.validate(self)
    }
    
    func validationSuccessful() {
        
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
    
    func validationFailed(errors:[UITextField:ValidationError]) {
        // turn the fields to red
        for (field, _) in validator.errors {
            let errorColor = UIColor.redColor().colorWithAlphaComponent(0.25).CGColor
            field.layer.backgroundColor = errorColor
//            error.errorLabel?.text = error.errorMessage // works if you added labels
//            error.errorLabel?.hidden = false
        }
    }
    
    func textFieldDidBeginEditing(textField: UITextField){
        textField.layer.borderColor = nil
        textField.layer.borderWidth = 0
    }
    
    func hideKeyboard(){
        view.endEditing(true)
    }
}
