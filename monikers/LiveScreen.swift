//
//  ViewController.swift
//  monikers
//
//  Created by Jason Hoang on 3/6/18.
//  Copyright © 2018 Jason Hoang. All rights reserved.
//

import UIKit

class LiveScreen: UIViewController, UITextFieldDelegate{

    var seconds = 10
    var numberOfWords = 0
    
   
    var timer = Timer()
    var liveScreenWords: String?
    var arrayTest: [String] = [ ]
    var shuffledArray: [String] = [ ]
    var arrayTracker = 0
    var teamTracker = 1
  
 
    @IBOutlet weak var word: UILabel! //display the word
    @IBOutlet weak var countDown: UILabel! //countdown label
    @IBOutlet weak var buttonTappedLabel: UIButton! //enter label
    @IBOutlet weak var wordsLeft: UILabel! //words left in the deck
    @IBOutlet weak var gotItLabel: UIButton!
    @IBOutlet weak var skipLabel: UIButton! //cycle through words
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let nameToDisplay = liveScreenWords {
            word.text = nameToDisplay
        }
        
        if let test = liveScreenWords { //initializing?
            wordsLeft.text = test
        }
        word.isHidden = true
        shuffledArray = shuffleArray(arrayToBeShuffled: arrayTest)
        numberOfWords = shuffledArray.count
        wordsLeft.text = String(numberOfWords)
        skipLabel.isHidden = true
        gotItLabel.isHidden = true
        
        if teamTracker == 1 {
            view.backgroundColor = .red
        } else {
            view.backgroundColor = .blue
        }
    }
    
     func viewWillAppear() {
        if teamTracker == 1 {
            view.backgroundColor = .red
        } else {
            view.backgroundColor = .blue
        }
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
    
    func nextElement() { //goes to the next element in the array of shuffledArray
        arrayTracker = arrayTracker + 1
        if arrayTracker >= shuffledArray.count {
            arrayTracker = 0
        }
       word.text = shuffledArray[arrayTracker]
    }
    
    func switchTeam() {
        if teamTracker == 1 {
            teamTracker = 2
        } else {
            teamTracker = 1}
    }
    
    
    
    @IBAction func buttonTapped(_ sender: Any) { //start button
        
        skipLabel.isHidden = false
        gotItLabel.isHidden = false
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(LiveScreen.counter), userInfo: nil, repeats: true)
        buttonTappedLabel.isHidden = true
       
        word.isHidden = false
        print(shuffledArray)
        if shuffledArray.isEmpty == false {
            
            word.text = shuffledArray.first //displays the first word
        }
}
    
    @IBAction func gotIt(_ sender: Any) { //got it button
        
        if numberOfWords > 0 { //track the amount of words left
            numberOfWords -= 1
            wordsLeft.text = String(numberOfWords)
        }
        if shuffledArray.count == 2 { //hides the skip when there is one word left
            skipLabel.isHidden = true
        }
        if shuffledArray.isEmpty == false { //removes the current word and goes to the next one. Cycles through the whole deck
           if shuffledArray[arrayTracker] == shuffledArray.last {
                nextElement()
                shuffledArray.removeLast()
            } else {
                nextElement()
                shuffledArray.remove(at: arrayTracker - 1)
            }
        }
        
}
    
    @IBAction func skip(_ sender: Any) {//skip button
        nextElement()
}
    
    
    @objc func counter() {
        seconds -= 1
        countDown.text = String(seconds)
        
        if (seconds == 0) {
            timer.invalidate()
            arrayTest = shuffledArray
            switchTeam()
            performSegue(withIdentifier: "goBackMainMenu", sender: self) //go back button is hidden from view
         
    }
}
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? MainMenu {
            destination.runningWords = arrayTest
            destination.teamTracker = teamTracker
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }



}



