//
//  APIService.swift
//  DeckOfCardsCodeChallenge
//
//  Created by Paul Bunnell on 3/21/21.
//

import Foundation

class CardController {
    
    func fetchCards(completion: @escaping ([Card]) -> Void) {
        
        let url = URL(string: "https://deckofcardsapi.com/api/deck/new/draw/?count=5")!
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            let decoder = JSONDecoder()
            if let data = data, let results = try? decoder.decode(CardResponse.self, from: data) {
                print("Results Recieved")
                completion(results.cards)
            } else {
                print("ERROR no data was returned from API")
                return
            }
            
        }
        
        task.resume()
        
    }
    
}
