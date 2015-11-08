//
//  SecondViewController.swift
//  FingTech
//
//  Created by fixd on 11/6/15.
//  Copyright © 2015 fixd. All rights reserved.
//

import UIKit
import LocalAuthentication

class MerchantViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var cardPicker: UIPickerView!
    
    var paymentAmount = 3.50
    
    var cards = CardSource.getCards()
    
    let context : LAContext = LAContext()
    
//    var currentCard: CreditCard?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var error = NSError?()
        let reasonString = "Authentication is required for payment"
        
        if context.canEvaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, error: &error) {
            [context .evaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, localizedReason: reasonString, reply: { (success: Bool, evalPolicyError: NSError?) -> Void in
                
                if success {
                    //yay!
                }
                else{
                    print(evalPolicyError?.localizedDescription)
                    
                    switch evalPolicyError!.code {
                        
                    case LAError.SystemCancel.rawValue:
                        self.showError("Authentication was cancelled by the system")
                        
                    case LAError.UserCancel.rawValue:
                        self.showError("Authentication was cancelled by the user")
                        
                    case LAError.UserFallback.rawValue:
                        self.showError("Fingerprint required")
//                        NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
//                            self.showPasswordAlert()
//                        })
                        
                    default:
                        self.showError("Authentication failed")
//                        NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
//                            self.showPasswordAlert()
//                        })
                    }
                }
                
            })]
        }else{
            showError("Fingerprint technology not available on this device.")
        }
    }

    func showError(message: String){
        UIAlertView(title: "Error", message: message, delegate: nil, cancelButtonTitle: "Cancel").show()
//        view.hidden = true
    }
    
    @IBAction func makePayment(sender: UIButton) {
        let currentCard = cards[row]
//        if(currentCard != nil){
            currentCard.charge(paymentAmount, completionHandler: { (success:Bool) -> Void in
                if(success){
                    UIAlertView(title: "Success", message: "Your card has been charged $\(self.paymentAmount).", delegate: nil, cancelButtonTitle: "Awesome!").show()
                }else{
                    UIAlertView(title: "Failure", message: "There was a problem processing the payment. Your card has not been charged.", delegate: nil, cancelButtonTitle: "Dag, yo").show()
                }
            })
//        }else{
//            UIAlertView(title: "Failure", message: "Please select a card first!", delegate: nil, cancelButtonTitle: "Sorry...").show()
//        }
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cards.count
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return cards[row].encodedNumber
    }
    
    var row = 0
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("selected \(row)")
        self.row = row
        //on clicked
//        currentCard = cards[row]
    }
    
    //UIAlertController(title: "Success", message: "You are validated!", preferredStyle: UIAlertControllerStyle.Alert)
    
    //        let card = items[indexPath.row]
    //        let amount = 15.00
    //        card.charge(amount) { (success:Bool) -> Void in
    //            if(success){
    //                UIAlertView(title: "Success", message: "Your card has been charged $\(amount).", delegate: nil, cancelButtonTitle: "Awesome!").show()
    //            }else{
    //                UIAlertView(title: "Failure", message: "There was a problem processing the payment. Your card has not been charged.", delegate: nil, cancelButtonTitle: "Dag, yo").show()
    //            }
    //        }

}

