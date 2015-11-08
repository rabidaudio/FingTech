//
//  CreditCard.swift
//  FingTech
//
//  Created by fixd on 11/7/15.
//  Copyright © 2015 fixd. All rights reserved.
//

import Foundation

import Alamofire

class CreditCard : NSObject, NSCoding {
    
    private let headers = ["Authorization": "Basic ODAwNTM2ODpqVllKU05JZ2I3Y2U=", "Content-Type": "application/json"]
    private let developerId = 12345678
    private let chargeEndpoint = "https://gwapi.demo.securenet.com/api/Payments/Charge"
    private let version = "1.2"
    private let fillerCharacter = "*"
    
    var holderName:String
    var number:Int64
    var cvv:Int
    var expireMonth:Int
    var expireYear:Int
    
    var company = "Nov8 Inc"
    var line1 = "123 Main St."
    var city = "Austin"
    var state = "TX"
    var zipcode = 78759
    
    var encodedNumber:String {
        get {
            var stringNumber = "\(number)"
            let rangeOfX = stringNumber.startIndex...stringNumber.endIndex.advancedBy(-4)
            stringNumber.replaceRange(rangeOfX, with: rangeOfX.map({_ in fillerCharacter}).joinWithSeparator(""))
            return stringNumber
        }
    }
    
    var expireDate:String {
        get {
            return "\(expireMonth)/\(expireYear)"
        }
    }
    
    override init() {
        holderName = "John Doe"
        number = 4111111111111111
        cvv = 123
        expireMonth = 07
        expireYear = 2018
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        self.init()
        if let holderName = aDecoder.decodeObjectForKey("holderName") as? String {
            self.holderName = holderName
        }
        if let number = aDecoder.decodeObjectForKey("number") as? String {
            self.number = Int64(number)!
        }
        if let cvv = aDecoder.decodeObjectForKey("cvv") as? Int {
            self.cvv = cvv
        }
        if let expireMonth = aDecoder.decodeObjectForKey("expireMonth") as? Int {
            self.expireMonth = expireMonth
        }
        if let expireYear = aDecoder.decodeObjectForKey("expireYear") as? Int {
            self.expireYear = expireYear
        }
        
        if let company = aDecoder.decodeObjectForKey("company") as? String {
            self.company = company
        }
        if let line1 = aDecoder.decodeObjectForKey("line1") as? String {
            self.line1 = line1
        }
        if let city = aDecoder.decodeObjectForKey("city") as? String {
            self.city = city
        }
        if let state = aDecoder.decodeObjectForKey("state") as? String {
            self.state = state
        }
        if let zipcode = aDecoder.decodeObjectForKey("zipcode") as? Int {
            self.zipcode = zipcode
        }
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(holderName, forKey: "holderName")
        aCoder.encodeObject("\(number)", forKey: "number")
        aCoder.encodeObject(cvv, forKey: "cvv")
        aCoder.encodeObject(expireMonth, forKey: "expireMonth")
        aCoder.encodeObject(expireYear, forKey: "expireYear")
        
        aCoder.encodeObject(company, forKey: "company")
        aCoder.encodeObject(line1, forKey: "line1")
        aCoder.encodeObject(city, forKey: "city")
        aCoder.encodeObject(state, forKey: "state")
        aCoder.encodeObject(zipcode, forKey: "zipcode")
    }
    
    init(holderName: String, number: Int64, cvv: Int, expireMonth: Int, expireYear: Int, zipcode: Int){
        self.holderName = holderName
        self.number = number
        self.cvv = cvv
        self.expireMonth = expireMonth
        self.expireYear = expireYear
        self.zipcode = zipcode
    }
    
//    init(params: NSDictionary){
//        self.holderName = String(params.objectForKey("holderName") as! NSString)
//        self.number = Int64(params.objectForKey("number") as! NSString)!
//        self.cvv = Int(params.objectForKey("cvv") as! NSNumber)
//        self.expireMonth = Int(params.objectForKey("expireMonth") as! NSNumber)
//        self.expireYear = Int(params.objectForKey("expireYear") as! NSNumber)
//        
//        self.company = String(params.objectForKey("company") as! NSString)
//        self.line1 = String(params.objectForKey("line1") as! NSString)
//        self.city = String(params.objectForKey("city") as! NSString)
//        self.state = String(params.objectForKey("state") as! NSString)
//        self.zipcode = Int(params.objectForKey("zipcode") as! NSNumber)
//    }
//    
//    func toPropertyList() -> NSDictionary {
//        let params = NSDictionary()
//        params.setValue(NSString(UTF8String: holderName), forKey: "holderName")
//        params.setValue(NSString(UTF8String: "\(number)"), forKey: "number")
//        params.setValue((cvv), forKey: "cvv")
//        params.setValue(NSNumber(expireMonth), forKey: "expireMonth")
//        params.setValue(NSNumber(expireYear), forKey: "expireYear")
//        params.setValue(NSString(company), forKey: "company")
//        params.setValue(NSString(line1), forKey: "line1")
//        params.setValue(NSString(city), forKey: "city")
//        params.setValue(NSString(state), forKey: "state")
//        params.setValue(NSNumber(zipcode), forKey: "zipcode")
//        
//        return params
//    }
    
    private func parameters(amount:Double) -> [String:AnyObject] {
        return [
            "amount": amount,
            "card": [
                "number": "\(number)",
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
