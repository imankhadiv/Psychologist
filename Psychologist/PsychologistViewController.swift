//
//  ViewController.swift
//  Psychologist
//
//  Created by Iman Rastkhadiv on 02/04/2015.
//  Copyright (c) 2015 Iman Rastkhadiv. All rights reserved.
//

import UIKit

class PsychologistViewController: UIViewController {

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let hvc = segue.destinationViewController as? HappynessViewController {
            if let identifier = segue.identifier {
                switch identifier {
                    case "sad": hvc.happiness = 0
                    case "happy": hvc.happiness = 100
                    default: hvc.happiness = 50
                }
            }
        }
    }

}

