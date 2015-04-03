//
//  DiagnosedHappinessViewController.swift
//  Psychologist
//
//  Created by Iman Rastkhadiv on 03/04/2015.
//  Copyright (c) 2015 Iman Rastkhadiv. All rights reserved.
//

import UIKit

class DiagnosedHappinessViewController: HappynessViewController
    
{
   override var happiness: Int { // 0 = very sad and 100 = very
        
        didSet {
           diagnosticHistory += [happiness]
        }
    }
    private let defaults = NSUserDefaults.standardUserDefaults()
    var diagnosticHistory: [Int] {
        set {defaults.setObject(newValue, forKey: History.DefaultsKey)}
    get { return defaults.objectForKey(History.DefaultsKey) as? [Int] ?? [] }
    }
    
    private struct History {
        static let SegueIdentifier = "Show Diagnostic History"
        static let DefaultsKey = "DiagnosedHappinessViewController.History"
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let identifier = segue.identifier {
            switch identifier {
            case History.SegueIdentifier:
                if let tvc = segue.destinationViewController as? TextViewController {
                    tvc.text = "\(diagnosticHistory)"
                }
            default: break
            }
        }
    }
    
}
