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
    @IBOutlet weak var wordCountLabel: UILabel!
   
    
    var numberOfWords = 0
    var allWords: [String] = []
    public var runningWords: [String] = []
   
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTextFields()
        configureTapGesture()
    }
    
    
    private func configureTextFields(){
        addWords.delegate = self
    }
    
    private func configureTapGesture(){ //hides the keyboard when touching outside part 1
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(MainMenu.handleTap))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTap() { //hides the keyboard when touching outside part 2
        print("Handle tap was called")
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool { //hides the keyboard
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        numberOfWords += 1 //updates the counter
        wordCountLabel.text = String(numberOfWords)
        allWords.append(addWords.text!) //adds what the user inputs to allWords array
        runningWords.append(addWords.text!) //add what user inputs to runningWords (update actively)
       // print(shuffleArray(arrayToBeShuffled: runningWords))
    }
    
    @IBAction func t1Start(_ sender: UIButton) {
    performSegue(withIdentifier: "t1Start", sender: self)
}
    
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? LiveScreen {
            //destination.liveScreenWords = addWords.text //might be incorreect
           // destination.testMe = runningWords.joined(separator: " ") //pass array over DO MORE RESEARCH -- this displays everything
            destination.arrayTest = runningWords
        }
    }
    
    
    @IBAction func t2Start(_ sender: UIButton) {

    }
    


}




    






    






