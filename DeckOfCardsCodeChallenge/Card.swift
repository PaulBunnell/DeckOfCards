//
//  Card.swift
//  DeckOfCardsCodeChallenge
//
//  Created by Paul Bunnell on 3/21/21.
//

import Foundation

struct Card: Codable {
    var image: String
    var value: String
    var suit: String
    var code: String
    
}

struct CardResponse: Codable {
    var success: Bool
    var cards: [Card]
    var deck_id: String
    var remaining: Int
    
}
