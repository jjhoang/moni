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
    
    
    
    @IBAction func currentWordsTest(_ sender: Any) {
    print("There are \(runningWords)")
    print("total words are \(allWords)")
        print("saved array is \(savedArray)")
    }
    
    var save = UserDefaults.standard
    var savedArray: [String] = []
    var numberOfWords = 0
    var allWords: [String] = []
    var teamTracker: Int = 1
    var team1 = 0
    var team2 = 0
    var runningScore = 0
    var started = false 
    public var runningWords: [String] = []
    
   
    override func viewDidLoad() {
        configureTextFields()
        configureTapGesture()
    
    }
    
   override func viewWillAppear(_ animated: Bool) {
        scoreUpdate()
    if started == true {
        addWords.isHidden = true
        wordCountLabel.isHidden = true
        wordCountWord.isHidden = true
        round.isHidden = false
    } else {
      round.isHidden = true
    }
     savedArray = save.stringArray(forKey: "allWords") ?? [String]()
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
        return true
    }
    
    func scoreUpdate() {
        
        if teamTracker == 1 {
            team2 = runningScore + team2
            UserDefaults.standard.set(team2, forKey: "team2")
            blueScore.text = String(team2)
            redScore.text = String(team1)
        } else {
            team1 = runningScore + team1
            UserDefaults.standard.set(team1, forKey: "team1")
            redScore.text = String(team1)
            blueScore.text = String(team2)
        }
       
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        numberOfWords += 1 //updates the counter
        wordCountLabel.text = String(numberOfWords)
        allWords.append(addWords.text!) //adds what the user inputs to allWords array
        runningWords.append(addWords.text!) //add what user inputs to runningWords (update actively)
        save.set(allWords, forKey: "allWords" )
    }

    func newRoundStart() {
        
      
      
    }
    
    func newGame() {
        
   
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
            
        }
    }
    
}




    






    






