//
//  AddWords.swift
//  monikers
//
//  Created by Jason Hoang on 3/29/18.
//  Copyright © 2018 Jason Hoang. All rights reserved.
//

import UIKit

var addedWords = 0
var everyWord: [String] = []
var originalWords1: [String] = []

class AddWords: UIViewController, UITextFieldDelegate  {
    
    
    override func viewDidLoad() {
        configureTextFields()
        configureTapGesture()
    }
    
    @IBAction func currentWords(_ sender: Any) { //for testing purposes
        print("words are currently \(originalWords1)")
    }
    

    @IBOutlet weak var addWords: UITextField!
    @IBOutlet weak var wordCount: UILabel!

    
    private func configureTextFields() {
        addWords.delegate = self
    }
  
    
    func textFieldDidEndEditing(_ textField: UITextField) {
            addedWords += 1 // updates counter
            wordCount.text = String(addedWords)
            print("this is being called")
            everyWord.append(addWords.text!) // add words to everyWord array
            originalWords1.append(addWords.text!) //add words to originalWords array
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
