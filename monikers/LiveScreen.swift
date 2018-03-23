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
    var shuffledArray: [String] = [ ]
 
    
    @IBOutlet weak var word: UILabel! //display the word
    @IBOutlet weak var countDown: UILabel! //countdown label
    @IBOutlet weak var buttonTappedLabel: UIButton! //enter label
    @IBOutlet weak var wordsLeft: UILabel! //words left in the deck

    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let nameToDisplay = liveScreenWords {
            word.text = nameToDisplay
        }
        word.isHidden = true
        shuffledArray = shuffleArray(arrayToBeShuffled: arrayTest)

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
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(LiveScreen.counter), userInfo: nil, repeats: true)
        buttonTappedLabel.isHidden = true
        word.isHidden = false
        print(shuffledArray)
        if shuffledArray.isEmpty == false {
            
            word.text = shuffledArray.first //displays the first word
        }

    }
    
    @IBAction func gotIt(_ sender: Any) { //got it button
    
    
        if shuffledArray.isEmpty == false {
            
            shuffledArray.removeFirst()
            word.text = shuffledArray.first
        } //else  return to first screen
    
}
    
    @IBAction func skip(_ sender: Any) {//skip button
    
        if shuffledArray.count > 2  {
            
        }
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


