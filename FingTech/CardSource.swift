//
//  CardSoruce.swift
//  FingTech
//
//  Created by fixd on 11/8/15.
//  Copyright © 2015 fixd. All rights reserved.
//

import Foundation

class CardSource {
    
    // hacky storage for credit cards. don't use in production! Use Core Data / Keystore
    
    private static let key = "CreditCards"
    
    static let userDefaults = NSUserDefaults.standardUserDefaults()
    
    static func getCards() -> [CreditCard] {
        return getOrPopulate().map({ NSKeyedUnarchiver.unarchiveObjectWithData($1) as! CreditCard })
    }
    
    static func saveCard(card: CreditCard) {
        let id = String(card.number)
        var cards = getOrPopulate()
        cards[id] = NSKeyedArchiver.archivedDataWithRootObject(card)
        userDefaults.setObject(cards, forKey: key)
    }
    
    private static func getOrPopulate() -> [String:NSData]{
        if let cards = userDefaults.objectForKey(key) as! [String:NSData]? {
            return cards
        }else{
            let card = CreditCard() //default card
            let cards = [String(card.number): NSKeyedArchiver.archivedDataWithRootObject(card)]
            userDefaults.setObject(cards, forKey: key)
            return cards
        }
    }
}