//
//  MainMenu.swift
//  monikers
//
//  Created by Jason Hoang on 3/12/18.
//  Copyright © 2018 Jason Hoang. All rights reserved.
//

import UIKit

class MainMenu: UIViewController, UITextFieldDelegate {

    
    
    @IBOutlet weak var addWords: UITextField!
    @IBOutlet weak var wordCountWord: UILabel!
    @IBOutlet weak var wordCountLabel: UILabel!
    @IBOutlet weak var redScore: UILabel!
    @IBOutlet weak var blueScore: UILabel!
    @IBOutlet weak var round: UILabel!
    @IBOutlet weak var wordsLeft: UILabel!
    @IBOutlet weak var startButtonLabel: UIButton!
    
 
    @IBAction func currentWordsTest(_ sender: Any) {
    print("There are \(runningWords)")
    print("total words are \(originalWords)")
    print("saved array is \(wordsForNewRound)")
    print("round is currently \(roundTracker)")
    }
    
    
    var save = UserDefaults.standard
    var wordsForNewRound: [String] = []
    var numberOfWords = 0
    var originalWords: [String] = [] //temp store words
    var teamTracker: Int = 1
    var team1 = 0
    var team2 = 0
    var runningScore = 0
    var started = false
    var roundTracker = 1
    public var runningWords: [String] = []
    
   
    override func viewDidLoad() {
        configureTextFields()
        configureTapGesture()
}
    
   override func viewWillAppear(_ animated: Bool) {
        scoreUpdate()
    if started == true { //when the game starts
        addWords.isHidden = true
        wordCountLabel.isHidden = true
        wordCountWord.isHidden = true
        round.isHidden = false
        wordsLeft.text = String(runningWords.count) //shows # remaining words
    } else { //when it hasn't started
      round.isHidden = true
      wordsLeft.text = String(addedWords)
    }
     wordsForNewRound = save.stringArray(forKey: "originalWords") ?? [String]() //loads words with the saved array
     newRoundStart()

    
   /* if runningWords.count < 1 && wordsForNewRound.count < 2 {
        
        startButtonLabel.isHidden = true
        print("it's  hidden")
        print("running words count \(runningWords.count)")
        print("wordsfornewround count \(wordsForNewRound.count)")
    }*/
    
}
    
   
    
    
    
    private func configureTextFields(){
        addWords.delegate = self
    }
    
    private func configureTapGesture(){ //hides the keyboard when touching outside part 1
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(MainMenu.handleTap))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTap() { //hides the keyboard when touching outside part 2
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool { //when user hits Done on keyboard
        textField.resignFirstResponder()
        textField.text = ""
       /* if originalWords.count > 2 || wordsForNewRound.count > 2 { //unhide the start button when at least 2 words are entered
             startButtonLabel.isHidden = false
         print("it's not hidden") }*/
        return true
    }
    
    
    func scoreUpdate() {
        
        if teamTracker == 1 {
            team2 = runningScore + team2
            save.set(team2, forKey: "team2")
            blueScore.text = String(team2)
            redScore.text = String(team1)
        } else {
            team1 = runningScore + team1
            save.set(team1, forKey: "team1")
            redScore.text = String(team1)
            blueScore.text = String(team2)
        }
       
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        
        numberOfWords += 1 //updates the counter
        wordCountLabel.text = String(numberOfWords)
        originalWords.append(addWords.text!) //adds what the user inputs to originalWords array
        runningWords.append(addWords.text!) //add what user inputs to runningWords (update actively)
        save.set(originalWords, forKey: "originalWords" )
    }

    func newRoundStart() {
        if roundTracker == 2 {
            round.text = "Round 2: One Word"
            startButtonLabel.isHidden = false
        } else if roundTracker == 3 {
             round.text = "Round 3: Charades"
             startButtonLabel.isHidden = false
        }
        if runningWords.count == 0 && wordsForNewRound.count > 1 {
            if roundTracker == 2 {
                round.text = "Round 2: One Word"
                 startButtonLabel.isHidden = false
                runningWords = wordsForNewRound
            } else if roundTracker == 3 {
                round.text = "Round 3: Charades"
                 startButtonLabel.isHidden = false
                runningWords = wordsForNewRound
            } else if roundTracker == 4 { //game over
                round.text = "GAME OVER"
                wordsForNewRound = []
                startButtonLabel.isHidden = true
            }
        }
      
    }
    
    func newGame() {
        
        //what needs to be done in a new game
        
    }
    

    
    @IBAction func t1Start(_ sender: Any) {
         performSegue(withIdentifier: "t1Start", sender: self)
           
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? LiveScreen {
            destination.arrayTest = runningWords
            destination.arrayTracker = 0
            destination.teamTracker = teamTracker
            destination.team3 = team1
            destination.team4 = team2
            destination.roundTracker = roundTracker
            
        }
    }
    
}




    






    






