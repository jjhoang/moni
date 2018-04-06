//
//  Confirmation.swift
//  monikers
//
//  Created by Jason Hoang on 4/5/18.
//  Copyright © 2018 Jason Hoang. All rights reserved.
//

import UIKit

class Confirmation: UIViewController {
    
    @IBOutlet weak var displayTeams: UILabel!
    @IBOutlet weak var numberOfWords: UILabel!
    @IBOutlet weak var timerCounter: UILabel!
    
    var deckSize = 0
    var timeSlider = 1
    var deckSlider = 1
    override func viewWillAppear(_ animated: Bool) {
        

        view.backgroundColor = UIColor(red:0.21, green:0.84, blue:0.72, alpha:1.0) //turquoise# 36D7B7
        
        numberOfWords.text = "Total words: " + String(deckSize) //displays number of words
        
        if timeSlider == 1 { //displays the appropriate time
            timerCounter.text = String("30 seconds for each turn")
            seconds = 30
        } else if timeSlider == 2 {
            timerCounter.text = String("45 seconds for each turn")
            seconds = 45
        } else if timeSlider == 3 {
            timerCounter.text = String("60 seconds for each turn")
            seconds = 60
        }
    }
        
    @IBAction func backButton(_ sender: Any) {
        
    }
    
    
    
    @IBAction func test(_ sender: Any) {
        print("deck size from Confirmation is \(deckSize)")
        print("time is set to \(seconds)")
        print("deck slider is\(deckSlider)")
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? AddWords {
            destination.deckSize = deckSize
        }
         if let setupDestination = segue.destination as? Setup {
            setupDestination.deckSliderValue = deckSlider
            setupDestination.timeCounter = timeSlider
            
}
}
}
