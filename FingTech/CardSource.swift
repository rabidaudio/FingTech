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
        if let cards = userDefaults.objectForKey(key) as! [CreditCard]? {
            return cards
        }else{
            return [CreditCard()] //save one card by default
        }
    }
    
    static func saveCard(card: CreditCard) {
        var cards = getCards()
        cards.append(card)
        userDefaults.setObject(cards, forKey: key)
    }
}