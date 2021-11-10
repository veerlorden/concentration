//
//  Card.swift
//  Concentration
//
//  Created by Вадим Буркин on 08.11.2021.
//

import Foundation

struct Card {
    var isFaceUp = false
    var isMatched = false
    var isSeen = false
    var identifier: Int
    
    private static var identifierFactory = 0
    
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
