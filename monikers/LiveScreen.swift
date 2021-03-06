//
//  ViewController.swift
//  monikers
//
//  Created by Jason Hoang on 3/6/18.
//  Copyright © 2018 Jason Hoang. All rights reserved.
//

import UIKit
import AVFoundation


class LiveScreen: UIViewController, UITextFieldDelegate{
    
    
    var beepSound:AVAudioPlayer!
    var endSound:AVAudioPlayer!
    
    var gameSeconds = 0 //local game seconds
    var save = UserDefaults.standard
    var numberOfWords = 0
    var timer = Timer()
    var timerForSound = Timer()
    var timerForSound2 = Timer()
    var timerForSound3 = Timer()
    var liveScreenWords: String?
    var arrayTest: [String] = [ ]
    var shuffledArray: [String] = [ ]
    var arrayTracker = 0 //the amount of words 
    var teamTracker = 1
    var roundTracker = 1
    var scoreUpdate = 0
    var team3 = 0
    var team4 = 0
    var started = true
  

   
    @IBOutlet weak var currentRoundLabel: UILabel! //display current round
    @IBOutlet weak var word: UILabel! //display the word
    @IBOutlet weak var countDown: UILabel! //countdown label
    @IBOutlet weak var buttonTappedLabel: UIButton! //enter label
    @IBOutlet weak var wordsLeft: UILabel! //words left in the deck
    @IBOutlet weak var gotItLabel: UIButton!
    @IBOutlet weak var skipLabel: UIButton! //cycle through words
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let nameToDisplay = liveScreenWords {
            word.adjustsFontSizeToFitWidth = true
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
            view.backgroundColor = UIColor(red:0.79, green:0.12, blue:0.22, alpha:1.0) //foreign crimson C91F37
        } else {
            view.backgroundColor = UIColor(red:0.10, green:0.71, blue:1.00, alpha:1.0)// #19B5FE dodger blue
        }

        let url = Bundle.main.url(forResource: "beep", withExtension: "mp3")
        let url2 = Bundle.main.url(forResource: "end", withExtension: "mp3")
        
        do {
            beepSound = try AVAudioPlayer(contentsOf: url!)
            beepSound.enableRate = true
            beepSound.prepareToPlay()
            endSound = try AVAudioPlayer(contentsOf: url2!)
            endSound.prepareToPlay()
            
            
        } catch let error as NSError {
            print(error.debugDescription)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        countDown.text = String(gameSeconds)
        currentRound()
       
    }
    
    func currentRound() {
       
        switch roundTracker {
        case 1:
            currentRoundLabel.text = "SAY ANYTHING"
        case 2:
            currentRoundLabel.text = "ONE WORD ONLY"
        case 3:
            currentRoundLabel.text = "ACT OUT"
        default:
            currentRoundLabel.text = "GAME OVER"
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
        gotItLabel.isHidden = false
        buttonTappedLabel.isHidden = true
        if shuffledArray.count == 1 { //hides the skip when there is one word left
            skipLabel.isHidden = true} else {
            skipLabel.isHidden = false
        }
        word.isHidden = false
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(LiveScreen.counter), userInfo: nil, repeats: true)
        timerForSound = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(LiveScreen.playSound), userInfo: nil, repeats: true)
        timerForSound2 = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(LiveScreen.playSound), userInfo: nil, repeats: true)
        timerForSound3 = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(LiveScreen.playSound), userInfo: nil, repeats: true)
        print(shuffledArray)
        if shuffledArray.isEmpty == false {
            
            word.text = shuffledArray.first //displays the first word
        }
}
    
    @IBAction func gotIt(_ sender: Any) { //got it button
        
        scoreUpdate += 1
        if numberOfWords > 0 { //track the amount of words left
            numberOfWords -= 1
            wordsLeft.text = String(numberOfWords)
        }
        if numberOfWords == 0 { //when all words are done then go to main menu
            shuffledArray = []
            roundTracker += 1
            endTurn()
        }
        if shuffledArray.count == 2 { //hides the skip when there is one word left
            skipLabel.isHidden = true
        }
        
        if shuffledArray.count > 1 { //removes the current word and goes to the next one. Cycles through the whole deck
            if let index = shuffledArray.index(of: word.text!) {
                shuffledArray.remove(at: index)
                nextElement()
            }
        }
 
}
    
    @IBAction func skip(_ sender: Any) {//skip button
        print("current round is \(roundTracker)")
        nextElement()

}
    
   @objc func playSound() {
        
        if gameSeconds > 30 { //play sounds at different rates
            beepSound.rate = 0.5
            beepSound.play()
            print("normal \(gameSeconds)")
            
        } else if gameSeconds > 15  { //15
            beepSound.rate = 1
            beepSound.play()
            print("faster \(gameSeconds)")
        } else if gameSeconds >  1 {  //15
            beepSound.rate = 2
            beepSound.play()
            print("fastest \(gameSeconds)")
            
        } else if gameSeconds > 0 {
            beepSound.stop()
            endSound.play()
            print("buzzer \(gameSeconds)")
        }
    }
    
    func endTurn() { //things to do at the end
        if roundTracker == 4 && numberOfWords == 0 {
            performSegue(withIdentifier: "endGame", sender: self)
            beepSound.stop()
        }
        arrayTest = shuffledArray
        switchTeam()
        performSegue(withIdentifier: "goBackMainMenu", sender: self)
        beepSound.stop()

    }
    
    
    @objc func counter() {
        gameSeconds -= 1
        countDown.text = String(gameSeconds)
    
        
        if (gameSeconds <= 0) {
            timer.invalidate()
             endTurn()
           
    }
}
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? MainMenu {
            if arrayTest.count >= 1 { //determine which array to pass on (either current or all)
                liveWords = arrayTest } else {
                liveWords = originalWords1              }
            destination.teamTracker = teamTracker
            destination.runningScore = scoreUpdate
            destination.team1 = team3
            destination.team2 = team4
            destination.started = started
            destination.roundTracker = roundTracker
            timer.invalidate() //stop timer when screen moves back to Main menu
                 timerForSound.invalidate()
                 timerForSound2.invalidate()
                 timerForSound3.invalidate()
            
    
            print("gameSecond is \(gameSeconds)")
            print("seconds is \(seconds)")
        
    }
}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }



}



