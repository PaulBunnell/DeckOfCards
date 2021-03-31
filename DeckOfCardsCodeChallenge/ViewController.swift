//
//  ViewController.swift
//  DeckOfCardsCodeChallenge
//
//  Created by Paul Bunnell on 3/21/21.
//

import UIKit

class ViewController: UIViewController {
    
    /*
     Using the deck of cards API draw 5 cards from a deck. Display all 5 of the cards on the screen. Give me the option to redraw a new hand of 5 cards. If you are looking for an extra challenge or an extra way to impress me. Add a button to evaluate the five cards on how good of a poker hand it is. Jack high, probably not that good. Royal Flush, really good, etc...
     */
    
    var cards = [Card]()
    
    var cardController = CardController()
    
    @IBOutlet weak var grabCardsButton: UIButton!
    @IBOutlet weak var card1Label: UILabel!
    @IBOutlet weak var card2Label: UILabel!
    @IBOutlet weak var card3Label: UILabel!
    @IBOutlet weak var card4Label: UILabel!
    @IBOutlet weak var card5Label: UILabel!  
    @IBOutlet weak var card1: UIImageView!
    @IBOutlet weak var card2: UIImageView!
    @IBOutlet weak var card3: UIImageView!
    @IBOutlet weak var card4: UIImageView!
    @IBOutlet weak var card5: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        card1Label.text = ""
        card2Label.text = ""
        card3Label.text = ""
        card4Label.text = ""
        card5Label.text = ""
                
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "feltBackDropImage")!)
        
        grabCardsButton.layer.cornerRadius = 10
    }
    
    
    @IBAction func pickCardsButtonTapped(_ sender: UIButton) {

        cardController.fetchCards { (cards) in
            DispatchQueue.main.async {
                self.cards = cards
                self.updateUI(cardInfo: self.cards[0], cardImage: self.card1, cardLabel: self.card1Label)
                self.updateUI(cardInfo: self.cards[1], cardImage: self.card2, cardLabel: self.card2Label)
                self.updateUI(cardInfo: self.cards[2], cardImage: self.card3, cardLabel: self.card3Label)
                self.updateUI(cardInfo: self.cards[3], cardImage: self.card4, cardLabel: self.card4Label)
                self.updateUI(cardInfo: self.cards[4], cardImage: self.card5, cardLabel: self.card5Label)
            }
        }
        
        
    }
    
    @IBAction func infoButtonTapped(_ sender: UIBarButtonItem) {
        
        evaluateCards(evaluatedCards: cards)
        
    }
    
    
    func updateUI(cardInfo: Card, cardImage: UIImageView, cardLabel: UILabel) {
        
        let task = URLSession.shared.dataTask(with: URL(string: cardInfo.image)!) { (data, response, error) in
            
            guard let data = data, let image = UIImage(data: data) else {return}
            
            DispatchQueue.main.async {
                cardImage.image = image
            }
            
        }
        
        task.resume()
        
        cardLabel.text = cardInfo.code
        
    }
    
    
    
    var suits: [String : String] = ["hearts" : "HEARTS", "spades" : "SPADES", "clubs" : "CLUBS", "diamonds" : "DIAMONDS"]
    
    func evaluateCards(evaluatedCards: [Card]) {
        
        var hearts = [Card]()
        var spades = [Card]()
        var clubs = [Card]()
        var diamonds = [Card]()
        
        var ace = [Card]()
        var king = [Card]()
        var queen = [Card]()
        var jack = [Card]()
        var ten = [Card]()
        var nine = [Card]()
        var eight = [Card]()
        var seven = [Card]()
        var six = [Card]()
        var five = [Card]()
        var four = [Card]()
        var three = [Card]()
        var two = [Card]()
        var one = [Card]()

        for i in evaluatedCards {
            if i.suit == suits["hearts"] {
                hearts.append(i)
            }
            if i.suit == suits["spades"] {
                spades.append(i)
            }
            if i.suit == suits["clubs"] {
                clubs.append(i)
            }
            if i.suit == suits["diamonds"] {
                diamonds.append(i)
            }
        }
        
        for i in evaluatedCards {
            if i.value == "ACE" {
                ace.append(i)
            }
            if i.value == "KING" {
                king.append(i)
            }
            if i.value == "QUEEN" {
                queen.append(i)
            }
            if i.value == "JACK" {
                jack.append(i)
            }
            if i.value == "10" {
                ten.append(i)
            }
            if i.value == "9" {
                nine.append(i)
            }
            if i.value == "8" {
                eight.append(i)
            }
            if i.value == "7" {
                seven.append(i)
            }
            if i.value == "6" {
                six.append(i)
            }
            if i.value == "5" {
                five.append(i)
            }
            if i.value == "4" {
                four.append(i)
            }
            if i.value == "3" {
                three.append(i)
            }
            if i.value == "2" {
                two.append(i)
            }
            if i.value == "1" {
                one.append(i)
            }
        }
        
        print("Ace: \(ace.count)")
        print("King: \(king.count)")
        print("Queen: \(queen.count)")
        print("Jack: \(jack.count)")
        print("Ten: \(ten.count)")
        print("Nine: \(nine.count)")
        print("Eight: \(eight.count)")
        print("Seven: \(seven.count)")
        print("Six: \(six.count)")
        print("Five: \(five.count)")
        print("Four: \(four.count)")
        print("Three: \(three.count)")
        print("Two: \(two.count)")
        print("One: \(one.count)")
        print()
        print("Hearts: \(hearts.count)")
        print("Spades: \(spades.count)")
        print("Clubs: \(clubs.count)")
        print("Diamonds: \(diamonds.count)")
        
        // Royal Flush
        if hearts.count == 5 || spades.count == 5 || clubs.count == 5 || diamonds.count == 5 && ace.count == 1 && king.count == 1 && queen.count == 1 && jack.count == 1 && ten.count == 1{
            let alert = UIAlertController(title: "Royal Flush!", message: "You have a Royal Flush!", preferredStyle: .alert)
            let action = UIAlertAction(title: "Okay", style: .default, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
        // Full House
//        else if ace.count == 3 || king.count == 3 || queen.count == 3 || jack.count == 3 || ten.count == 3 || nine.count == 3 || eight.count == 3 || seven.count == 3 || six.count == 3 || five.count == 3 || four.count == 3 || three.count == 3 || two.count == 3 || one.count == 3 && ace.count == 2 || king.count == 2 || queen.count == 2 || jack.count == 2 || ten.count == 2 || nine.count == 2 || eight.count == 2 || seven.count == 2 || six.count == 2 || five.count == 2 || four.count == 2 || three.count == 2 || two.count == 2 || one.count == 2 {
//            let alert = UIAlertController(title: "Full House!", message: "You have a Full House!", preferredStyle: .alert)
//            let action = UIAlertAction(title: "Okay", style: .default, handler: nil)
//            alert.addAction(action)
//            present(alert, animated: true, completion: nil)
//
//        }
        // Four of a kind
        else if ace.count == 4 || king.count == 4 || queen.count == 4 || jack.count == 4 || ten.count == 4 || nine.count == 4 || eight.count == 4 || seven.count == 4 || six.count == 4 || five.count == 4 || four.count == 4 || three.count == 4 || two.count == 4 || one.count == 4 {
            let alert = UIAlertController(title: "Four of a Kind!", message: "You have Four of a Kind!", preferredStyle: .alert)
            let action = UIAlertAction(title: "Okay", style: .default, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
        //Flush
        else if hearts.count == 5 || spades.count == 5 || clubs.count == 5 || diamonds.count == 5 {
            let alert = UIAlertController(title: "Flush!", message: "You have a Flush!", preferredStyle: .alert)
            let action = UIAlertAction(title: "Okay", style: .default, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
        //Three of a kind
        else if ace.count == 3 || king.count == 3 || queen.count == 3 || jack.count == 3 || ten.count == 3 || nine.count == 3 || eight.count == 3 || seven.count == 3 || six.count == 3 || five.count == 3 || four.count == 3 || three.count == 3 || two.count == 3 || one.count == 3 {
            let alert = UIAlertController(title: "Three of a Kind!", message: "You have Three of a Kind!", preferredStyle: .alert)
            let action = UIAlertAction(title: "Okay", style: .default, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
        //Two Pairs
//        else if ace.count == 2 || king.count == 2 || queen.count == 2 || jack.count == 2 || ten.count == 2 || nine.count == 2 || eight.count == 2 || seven.count == 2 || six.count == 2 || five.count == 2 || four.count == 2 || three.count == 2 || two.count == 2 || one.count == 2 && ace.count == 2 || king.count == 2 || queen.count == 2 || jack.count == 2 || ten.count == 2 || nine.count == 2 || eight.count == 2 || seven.count == 2 || six.count == 2 || five.count == 2 || four.count == 2 || three.count == 2 || two.count == 2 || one.count == 2 {
//            let alert = UIAlertController(title: "Two Pairs!", message: "You have Two Pairs!", preferredStyle: .alert)
//            let action = UIAlertAction(title: "Okay", style: .default, handler: nil)
//            alert.addAction(action)
//            present(alert, animated: true, completion: nil)
//        }
        //Pair
        else if ace.count == 2 || king.count == 2 || queen.count == 2 || jack.count == 2 || ten.count == 2 || nine.count == 2 || eight.count == 2 || seven.count == 2 || six.count == 2 || five.count == 2 || four.count == 2 || three.count == 2 || two.count == 2 || one.count == 2 {
            let alert = UIAlertController(title: "Pair!", message: "You have a Pair!", preferredStyle: .alert)
            let action = UIAlertAction(title: "Okay", style: .default, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
        else {
            if ace.count == 1 {
                let alert = UIAlertController(title: "Highest card", message: "Your highest card is an Ace", preferredStyle: .alert)
                let action = UIAlertAction(title: "Okay", style: .default, handler: nil)
                alert.addAction(action)
                present(alert, animated: true, completion: nil)
            }
            else if king.count == 1 {
                let alert = UIAlertController(title: "Highest card", message: "Your highest card is a King", preferredStyle: .alert)
                let action = UIAlertAction(title: "Okay", style: .default, handler: nil)
                alert.addAction(action)
                present(alert, animated: true, completion: nil)
            }
            else if queen.count == 1 {
                let alert = UIAlertController(title: "Highest card", message: "Your highest card is a Queen", preferredStyle: .alert)
                let action = UIAlertAction(title: "Okay", style: .default, handler: nil)
                alert.addAction(action)
                present(alert, animated: true, completion: nil)
            }
            else if jack.count == 1 {
                let alert = UIAlertController(title: "Highest card", message: "Your highest card is a Jack", preferredStyle: .alert)
                let action = UIAlertAction(title: "Okay", style: .default, handler: nil)
                alert.addAction(action)
                present(alert, animated: true, completion: nil)
            }
            else if ten.count == 1 {
                let alert = UIAlertController(title: "Highest card", message: "Your highest card is a Ten", preferredStyle: .alert)
                let action = UIAlertAction(title: "Okay", style: .default, handler: nil)
                alert.addAction(action)
                present(alert, animated: true, completion: nil)            }
            else if nine.count == 1 {
                let alert = UIAlertController(title: "Highest card", message: "Your highest card is a Nine", preferredStyle: .alert)
                let action = UIAlertAction(title: "Okay", style: .default, handler: nil)
                alert.addAction(action)
                present(alert, animated: true, completion: nil)            }
            else if eight.count == 1 {
                let alert = UIAlertController(title: "Highest card", message: "Your highest card is a Eight", preferredStyle: .alert)
                let action = UIAlertAction(title: "Okay", style: .default, handler: nil)
                alert.addAction(action)
                present(alert, animated: true, completion: nil)            }
            else if seven.count == 1 {
                let alert = UIAlertController(title: "Highest card", message: "Your highest card is a Seven", preferredStyle: .alert)
                let action = UIAlertAction(title: "Okay", style: .default, handler: nil)
                alert.addAction(action)
                present(alert, animated: true, completion: nil)            }
            else if six.count == 1 {
                let alert = UIAlertController(title: "Highest card", message: "Your highest card is a Six", preferredStyle: .alert)
                let action = UIAlertAction(title: "Okay", style: .default, handler: nil)
                alert.addAction(action)
                present(alert, animated: true, completion: nil)            }
            else if five.count == 1 {
                let alert = UIAlertController(title: "Highest card", message: "Your highest card is a Five", preferredStyle: .alert)
                let action = UIAlertAction(title: "Okay", style: .default, handler: nil)
                alert.addAction(action)
                present(alert, animated: true, completion: nil)            }
            else if four.count == 1 {
                let alert = UIAlertController(title: "Highest card", message: "Your highest card is a Four", preferredStyle: .alert)
                let action = UIAlertAction(title: "Okay", style: .default, handler: nil)
                alert.addAction(action)
                present(alert, animated: true, completion: nil)            }
            else if three.count == 1 {
                let alert = UIAlertController(title: "Highest card", message: "Your highest card is a Three", preferredStyle: .alert)
                let action = UIAlertAction(title: "Okay", style: .default, handler: nil)
                alert.addAction(action)
                present(alert, animated: true, completion: nil)
            }
            else if two.count == 1 {
                let alert = UIAlertController(title: "Highest card", message: "Your highest card is a Two", preferredStyle: .alert)
                let action = UIAlertAction(title: "Okay", style: .default, handler: nil)
                alert.addAction(action)
                present(alert, animated: true, completion: nil)
            }
            else if one.count == 1 {
                let alert = UIAlertController(title: "Highest card", message: "Your highest card is a One", preferredStyle: .alert)
                let action = UIAlertAction(title: "Okay", style: .default, handler: nil)
                alert.addAction(action)
                present(alert, animated: true, completion: nil)
            }
            
        }
        
    }

}

