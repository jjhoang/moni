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
    var testMe: String?
    
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
        
        if let nameToDisplay = testMe {
            test.text = nameToDisplay
        }
    }
    
    @IBAction func buttonTapped(_ sender: Any) { //start button
        print("button was tapped")
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(LiveScreen.counter), userInfo: nil, repeats: true)
        buttonTappedLabel.isHidden = true
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



