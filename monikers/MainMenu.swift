//
//  MainMenu.swift
//  monikers
//
//  Created by Jason Hoang on 3/12/18.
//  Copyright © 2018 Jason Hoang. All rights reserved.
//

import UIKit

class MainMenu: UIViewController, UITextFieldDelegate {

    @IBAction func test(_ sender: Any) { //testing purposes
        
        print("round is \(roundTracker)")
 
    }
    
    
    @IBOutlet weak var redScore: UILabel!
    @IBOutlet weak var blueScore: UILabel!
    @IBOutlet weak var round: UILabel!
    @IBOutlet weak var wordsLeft: UILabel!
    @IBOutlet weak var startButtonLabel: UIButton!
    @IBOutlet weak var numberOfWordsLabel: UILabel!
    
 
    @IBAction func currentWordsTest(_ sender: Any) {
    print("saved array is \(wordsForNewRound)")
    print("round is currently \(roundTracker)")
    print("LiveWords is currently \(liveWords)")
    print("OriginalWords1 is currently \(originalWords1)")
        
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

    
   
    override func viewDidLoad() {
        configureTapGesture()
}
    
   override func viewWillAppear(_ animated: Bool) {
         newRoundStart()
        scoreUpdate()
    if started == true { //when the game starts
        round.isHidden = false
        wordsLeft.text = String(liveWords.count) //shows # remaining words
    } else { //when it hasn't started
      wordsLeft.text = String(addedWords)
    }
     wordsForNewRound = save.stringArray(forKey: "originalWords1") ?? [String]() //assign it to WordsforNewRound
     save.set(originalWords1, forKey: "originalWords1" )//save the originalWords1
    print("viewwillappear called")
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
    

    func newRoundStart() {
        
        if roundTracker == 2 {
            round.text = "Round 2: One Word"
            startButtonLabel.isHidden = false
        } else if roundTracker == 3 {
             round.text = "Round 3: Charades"
             startButtonLabel.isHidden = false
        } else if roundTracker == 4 {
            round.text = "GAME OVER"
            originalWords1 = []
            startButtonLabel.isHidden = true
            wordsLeft.isHidden = true
            numberOfWordsLabel.isHidden = true
            print("GAME OVER")
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
            destination.arrayTest = liveWords
            destination.arrayTracker = 0
            destination.teamTracker = teamTracker
            destination.team3 = team1
            destination.team4 = team2
            destination.roundTracker = roundTracker
            
        }
    }
    
}




    






    






