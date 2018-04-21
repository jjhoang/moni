//
//  AddWords.swift
//  monikers
//
//  Created by Jason Hoang on 3/29/18.
//  Copyright © 2018 Jason Hoang. All rights reserved.
//

import UIKit

var addedWords = 0
var liveWords: [String] = []
var originalWords1: [String] = []



class AddWords: UIViewController, UITextFieldDelegate  {
    //use this array to fill the "remainder" cards
    var remainderDeck = [
        "Tesla", "Donald Trump", "Britney Spears", "Disney World", "Green Tea", "Lemonade", "Michael Jackson", "John Mayer", "Selena Gomez", "Rocket",
        "Drunk", "Barack Obama", "Nintendo 64", "Prison Break", "Game of Thrones", "911", "1989", "New York Times", "Liberal", "Climate Change"
    ]
    
    let nextEndpoint = UILabel()
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var alert: UILabel!
    @IBOutlet weak var nextButtonLabel: UIButton!
    @IBOutlet weak var addThisMany: UILabel!
    var deckSize = 35
    var numberOfPlayers = 2
    var personalCardNumber = 0
    var cardsPerPerson = 1
    var duplicateArray = [""]

    override func viewDidLoad() {
        configureTextFields()
        configureTapGesture()
        nextButtonLabel.isHidden = true
        alert.isHidden = true
        view.backgroundColor = UIColor(red:0.21, green:0.84, blue:0.72, alpha:1.0) //turquoise# 36D7B7
       // nextButtonLabel.backgroundColor = .black
        //capture the endpoint for nextbutton label
        nextEndpoint.center = nextButtonLabel.center
     
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
    
        //determine how many cards each player adds
        print("decksize = \(deckSize) and # of players is \(numberOfPlayers)")
        cardsPerPerson = (deckSize / numberOfPlayers)
        
        //add this amount of cards into the deck
        let numberOfCardsLeft = deckSize % numberOfPlayers
        personalCardNumber = cardsPerPerson
        
        addThisMany.text = "ADD \(cardsPerPerson) MORE"
        notifyPlayer(title: "IMPORTANT", message: "Each player puts in \(personalCardNumber) words")
        
        //shuffle the miss cards
        let shuffledRemainder = shuffleArray(arrayToBeShuffled: remainderDeck)
        //add the shuffledremainder deck to the array to Add
        if numberOfCardsLeft != 0 {
        for card in 1...numberOfCardsLeft {
            addedWords += 1
             wordCount.text = String(addedWords)
             //add the content to the actual deck
            liveWords.append(String(describing: shuffledRemainder[card]))
            originalWords1.append(String(describing: shuffledRemainder[card]))
            duplicateArray.append(shuffledRemainder[card].uppercased().replacingOccurrences(of: " ", with: ""))
        }
        }
    
        print("Remainder: \(numberOfCardsLeft)")
        print("Cards per person \(cardsPerPerson)")
    }
    
    
    func shuffleArray(arrayToBeShuffled array1: [String]) -> [String] { //shuffle the array function
        var oldArray = array1
        var newArray = [String]()
        var randomNumber: Int
        
        for _ in array1 {
            randomNumber = Int(arc4random_uniform(UInt32(oldArray.count - 1)))
            newArray.append(oldArray[randomNumber])
            oldArray.remove(at: randomNumber)
        }
        return newArray
    }
    

    override func viewDidAppear(_ animated: Bool) {
      
    }
    
    @IBAction func currentWords(_ sender: Any) { //for testing purposes
        print("words are currently \(originalWords1)")
        print("\(deckSize)")
        print("number of players: \(numberOfPlayers)")
        print("number of cards per person \(cardsPerPerson)")
        
        
    }
    
    

    @IBOutlet weak var addWords: UITextField!
    @IBOutlet weak var wordCount: UILabel!

    
    private func configureTextFields() {
        addWords.delegate = self
    }
  
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        checkForDuplicate()
        //checks to see if the string is empty or has whitespaces and the added words is teh same as the determine deck size
        if (textField.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)! == false &&
            addedWords < deckSize &&
            checkForDuplicate() == false { 
            
           addedWords += 1 // updates counter
                
                if personalCardNumber == 1 && addedWords != deckSize {
                    
                    personalCardNumber = cardsPerPerson
                    addThisMany.text = String("ADD \(personalCardNumber) MORE")
                    notifyPlayer(title: "Pass to next player", message: "They will enter \(personalCardNumber) words")
                } else if personalCardNumber != 0 {
                    personalCardNumber -= 1
                    addThisMany.text = String("ADD \(personalCardNumber) MORE")
                }
                wordCount.text = String(addedWords)
                liveWords.append(addWords.text!) // add words to everyWord array]
                originalWords1.append(addWords.text!) //add words to originalWords array
                alert.isHidden = true
            //to check duplicate words
               let testedWord = textField.text?.uppercased().replacingOccurrences(of: " ", with: "")
               duplicateArray.append(testedWord!)
               print(testedWord!)
               print("duplicate array contains \(duplicateArray)")
              
    } else {
        return
    }
        if addedWords == deckSize {
            print("deck is full")
            nextButtonLabel.isHidden = false
            addThisMany.isHidden = true
            UIView.animate(withDuration: 0.3, animations: {
                
            })
            textField.isHidden = true
            alert.isHidden = false 
            alert.text = "Deck Complete!"
        }
    }
    
  @discardableResult func checkForDuplicate() -> Bool {
        let testedWord = textField.text?.uppercased().replacingOccurrences(of: " ", with: "")
        if duplicateArray.contains(testedWord!) && (textField.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)! == false {
            print("this is a duplicate do not add")
            alert.isHidden = false
            alert.text = "DUPLICATE WORD!"
            return true
        } else {
        return false
    }
    }
    func notifyPlayer(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "GOT IT!", style: UIAlertActionStyle.default, handler: { (action) in
            
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    

    func textFieldShouldReturn(_ textField: UITextField) -> Bool { //hides the keyboard when touching outside part 1
        textField.resignFirstResponder()
        textField.text = ""
        return true
    }
    
    @objc func handleTap() { //hides the keyboard when touching outside part 2
        view.endEditing(true)
    }
    
    private func configureTapGesture(){ //hides the keyboard when touching outside part 1
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(AddWords.handleTap))
        view.addGestureRecognizer(tapGesture)
    }
}
