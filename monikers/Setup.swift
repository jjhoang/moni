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
    
    @IBOutlet weak var deckCount: UILabel!
    @IBOutlet weak var deckSliderLabel: UISlider!
    @IBAction func thirtySeconds(_ sender: Any) {
        seconds = 30
       UserDefaults.standard.set(30, forKey: "seconds")
        performSegue(withIdentifier: "thirty", sender: self)
    }
    @IBAction func fourtyfiveSeconds(_ sender: Any) {
       seconds = 45
        UserDefaults.standard.set(45, forKey: "seconds")
         performSegue(withIdentifier: "fourtyfive", sender: self)
    }
    @IBAction func sixtySeconds(_ sender: Any) {
        seconds = 60
        UserDefaults.standard.set(60, forKey: "seconds")
        performSegue(withIdentifier: "sixty", sender: self)
    }

    @IBAction func deckSlider(_ sender: UISlider){
      deckSliderLabel.value = roundf(deckSliderLabel.value) //changes slider from a float to an int
      deckCount.text = String(Int(sender.value * 5 + 15)) //displays 20-50 int
    }
    
    @IBAction func next(_ sender: UIButton) {
       // let deckSize = deckSliderLabel
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let deckSize = Int(deckSliderLabel.value) * 5 + 15 //original value is from 1-7 and * 5 + 15 will get to the desired deck size of 20-50
        print("decksize is \(deckSize)")
    

}
}





