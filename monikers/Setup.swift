//
//  Setup.swift
//  monikers
//
//  Created by Jason Hoang on 3/31/18.
//  Copyright © 2018 Jason Hoang. All rights reserved.
//

import UIKit
var seconds = 45 //default if slider doesn't change

class Setup: UIViewController, UITextFieldDelegate {
    

    @IBOutlet weak var team1: UITextField!
    @IBOutlet weak var team2: UITextField!
    @IBOutlet weak var secondsLabel: UILabel!
    @IBOutlet weak var timeSliderLabel: UISlider!
    @IBOutlet weak var deckCount: UILabel!
    @IBOutlet weak var deckSliderLabel: UISlider!
    var deckSliderValue = 0
    var timeCounter = 0
    
    private func configureTextFields() {
        team1.delegate = self
        team2.delegate = self
    }
    
    override func viewDidLoad() {
        configureTextFields()
        configureTapGesture()
         view.backgroundColor = UIColor(red:0.21, green:0.84, blue:0.72, alpha:1.0) //turquoise# 36D7B7
        if deckSliderValue != 0 {
            deckSliderLabel.value = Float(deckSliderValue)
        }
        
        if timeCounter != 0 {
            timeSliderLabel.value = Float(timeCounter)
        }
    }
    @IBAction func deckSlider(_ sender: UISlider){
      deckSliderLabel.value = roundf(deckSliderLabel.value) //changes slider from a float to an int
      deckCount.text = String(Int(sender.value * 5 + 15)) + " words" //displays 20-50 int
    }
    @IBAction func timeSlider(_ sender: UISlider) {
    timeSliderLabel.value = roundf(timeSliderLabel.value)//changes slider from a float to an int
        if timeSliderLabel.value == 1 { //will set the timer depending on where the slider is
            secondsLabel.text = String("30 seconds")
            seconds = 30
        } else if timeSliderLabel.value == 2 {
            secondsLabel.text = String("45 seconds")
            seconds = 45
        } else if timeSliderLabel.value == 3 {
            secondsLabel.text = String("60 seconds")
            seconds = 60
        }
        
    }
    
    @IBAction func next(_ sender: UIButton) {
       // let deckSize = deckSliderLabel
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
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(Setup.handleTap))
        view.addGestureRecognizer(tapGesture)
    }



    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let deckSize = Int(deckSliderLabel.value) //* 5 + 15
        //original value is from 1-7 and * 5 + 15 will get to the desired deck size of 20-50
        if let destination = segue.destination as? Confirmation {
            destination.deckSize = deckSize
            destination.timeSlider = Int(timeSliderLabel.value)
            destination.deckSlider = Int(deckSliderLabel.value)
        }
        print("decksize is \(deckSize)")
    

}
}





