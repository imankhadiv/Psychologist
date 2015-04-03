//
//  TextViewController.swift
//  Psychologist
//
//  Created by Iman Rastkhadiv on 03/04/2015.
//  Copyright (c) 2015 Iman Rastkhadiv. All rights reserved.
//

import UIKit

class TextViewController: UIViewController {

    @IBOutlet weak var textView: UITextView! {
        didSet {
            textView.text = text
        }
    }
    
    var text: String = "" {
        didSet {
            textView?.text = text
        }
    }

}
