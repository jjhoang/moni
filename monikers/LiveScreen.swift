//
//  ViewController.swift
//  monikers
//
//  Created by Jason Hoang on 3/6/18.
//  Copyright © 2018 Jason Hoang. All rights reserved.
//

import UIKit

class LiveScreen: UIViewController {

    var seconds = 60
    var timer = Timer()
    var liveScreenWords: String?
    var arrayTest: [String] = [ ]
    
    @IBOutlet weak var word: UILabel! //display the word
    @IBOutlet weak var countDown: UILabel! //countdown label
    @IBOutlet weak var buttonTappedLabel: UIButton! //enter label
    @IBOutlet weak var wordsLeft: UILabel! //words left in the deck
    @IBOutlet weak var test: UILabel!
  
  
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let nameToDisplay = liveScreenWords {
            word.text = nameToDisplay
        }
    }
    
    func shuffleArray(arrayToBeShuffled array1: [String]) -> [String] { //shuffle the array function
        var oldArray = array1
        var newArray = [String]()
        var randomNumber: Int
        
        for _ in array1 {
            randomNumber = Int(arc4random_uniform(UInt32(oldArray.count - 1)))
            newArray.append(oldArray[randomNumber])
            oldArray.remove(at: randomNumber)
        }
        return newArray
    }
    
    @IBAction func buttonTapped(_ sender: Any) { //start button
        print("button was tapped")
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(LiveScreen.counter), userInfo: nil, repeats: true)
        buttonTappedLabel.isHidden = true
    }
    
    @IBAction func gotIt(_ sender: Any) { //got it button
    
        print(arrayTest)
    
}
    
    @IBAction func skip(_ sender: Any) {//skip button
    
    
}
    
    
    @objc func counter() {
        seconds -= 1
        countDown.text = String(seconds)
        
        if (seconds == 0) {
            timer.invalidate()
        }
    }
    

    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }



}



