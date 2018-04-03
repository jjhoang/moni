//
//  Setup.swift
//  monikers
//
//  Created by Jason Hoang on 3/31/18.
//  Copyright © 2018 Jason Hoang. All rights reserved.
//

import UIKit
//var seconds = 60
var resetTimer = 0

class Setup: UIViewController {
    
    @IBAction func thirtySeconds(_ sender: Any) {
        //seconds = 30
        //resetTimer = 30
        performSegue(withIdentifier: "thirty", sender: self)
    }
    @IBAction func fourtyfiveSeconds(_ sender: Any) {
       // seconds = 45
        //resetTimer = 45
         performSegue(withIdentifier: "fourtyfive", sender: self)
    }
    @IBAction func sixtySeconds(_ sender: Any) {
       // seconds = 60
       // resetTimer = 45
         performSegue(withIdentifier: "sixty", sender: self)
    }
}
