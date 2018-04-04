//
//  Setup.swift
//  monikers
//
//  Created by Jason Hoang on 3/31/18.
//  Copyright © 2018 Jason Hoang. All rights reserved.
//

import UIKit
var seconds = 60

class Setup: UIViewController {
    
    @IBOutlet weak var secondsLabel: UILabel!
    @IBOutlet weak var timeSliderLabel: UISlider!
    @IBOutlet weak var deckCount: UILabel!
    @IBOutlet weak var deckSliderLabel: UISlider!

    @IBAction func deckSlider(_ sender: UISlider){
      deckSliderLabel.value = roundf(deckSliderLabel.value) //changes slider from a float to an int
      deckCount.text = String(Int(sender.value * 5 + 15)) //displays 20-50 int
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
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let deckSize = Int(deckSliderLabel.value) //* 5 + 15
        //original value is from 1-7 and * 5 + 15 will get to the desired deck size of 20-50
        if let destination = segue.destination as? AddWords {
            destination.deckSize = deckSize 
        }
        print("decksize is \(deckSize)")
    

}
}





