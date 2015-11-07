//
//  CreditCard.swift
//  FingTech
//
//  Created by fixd on 11/7/15.
//  Copyright © 2015 fixd. All rights reserved.
//

import Foundation

import Alamofire

class CreditCard {
    
    private let headers = ["Authorization": "Basic ODAwNTM2ODpqVllKU05JZ2I3Y2U=", "Content-Type": "application/json"]
    
    private let developerId = 12345678
    
    private let chargeEndpoint = "https://gwapi.demo.securenet.com/api/Payments/Charge"
    
    private let version = "1.2"
    
    private let fillerCharacter = "*"
    
    var holderName:String = "John Doe"
    
    var cardNumber:Int = 4111111111111111
    
    var encodedNumber:String {
        get {
            var stringNumber = "\(cardNumber)"
            let rangeOfX = stringNumber.startIndex...stringNumber.endIndex.advancedBy(-4)
            stringNumber.replaceRange(rangeOfX, with: rangeOfX.map({_ in fillerCharacter}).joinWithSeparator(""))
            return stringNumber
        }
    }
    
    var cvv = 123
    
    var expireMonth = 07
    
    var expireYear = 2018
    
    var expireDate:String {
        get {
            return "\(expireMonth)/\(expireYear)"
        }
    }
    
    var company = "Nov8 Inc"

    var line1 = "123 Main St."
    
    var city  = "Austin"
    
    var state = "TX"
    
    var zipcode = 78759
    
    private func parameters(amount:Double) -> [String:AnyObject] {
        return [
            "amount": amount,
            "card": [
                "number": "\(cardNumber)",
                "cvv": "\(cvv)",
                "expirationDate": expireDate,
                "address":[
                    "company": "\(company)",
                    "line1": "\(line1)",
                    "city": "\(city)",
                    "state": "\(state)",
                    "zip": "\(zipcode)"
                ]
            ],
            "developerApplication": [
                "developerId": developerId,
                "version": version
            ]
        ]
    }
    
    func charge(amount:Double, completionHandler: Bool -> Void) {
        Alamofire.request(.POST, chargeEndpoint, headers: headers, parameters: parameters(amount), encoding: .JSON)
            .responseJSON { (response:Response<AnyObject, NSError>) -> Void in
                print(response)
                completionHandler(response.result.value?["result"] as? String == "APPROVED")
        }
    }
}
