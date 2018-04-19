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
    

    @IBOutlet weak var playerSliderLabel: UISlider!
    @IBOutlet weak var playerLabel: UILabel!
    @IBOutlet weak var secondsLabel: UILabel!
    @IBOutlet weak var timeSliderLabel: UISlider!
    @IBOutlet weak var deckCount: UILabel!
    @IBOutlet weak var deckSliderLabel: UISlider!
    var deckSliderValue = 0
    var timeCounter = 0
    var numberOfPlayers = 0
    

    
    override func viewDidLoad() {
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
    
    
    @IBAction func playerSlider(_ sender: Any) {
        // change slider from float to an int
        playerSliderLabel.value = roundf(playerSliderLabel.value)
        playerLabel.text = String(Int(playerSliderLabel.value)) + " players"
        numberOfPlayers = Int(playerSliderLabel.value)
    }
    
    
    @IBAction func next(_ sender: UIButton) {
       // let deckSize = deckSliderLabel
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let deckSize = Int(deckSliderLabel.value) * 5 + 15
        //original value is from 1-7 and * 5 + 15 will get to the desired deck size of 20-50
        if let destination = segue.destination as? AddWords {
            destination.deckSize = deckSize
            destination.numberOfPlayers = numberOfPlayers
        }
        
     
}
}





