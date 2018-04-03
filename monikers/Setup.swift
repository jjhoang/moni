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
}
