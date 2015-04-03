//
//  HappynessViewController.swift
//  Happyness
//
//  Created by Iman Rastkhadiv on 30/03/2015.
//  Copyright (c) 2015 Iman Rastkhadiv. All rights reserved.
//

import UIKit

class HappynessViewController: UIViewController, FaceViewDataSource {

    @IBOutlet weak var faceView: FaceView! {
        didSet {
            faceView.dataSource = self
            faceView.addGestureRecognizer(UIPinchGestureRecognizer(target: faceView, action: "scale:"))
        }
    }
    
    var happiness: Int = 50 { // 0 = very sad and 100 = very ecsatic
        
        didSet {
            happiness = min(max(happiness,0), 100)
            println("happiness = \(happiness)")
            updateUI()
        }
    }
    private struct Constants {
        static let HappinessGestureScale: CGFloat = 4
    }
    @IBAction func changeHappiness(gesture: UIPanGestureRecognizer) {
        
        switch gesture.state {
        case .Ended: fallthrough
        case .Changed:
            let translation = gesture.translationInView(faceView)
            let happinessChange = -Int(translation.y / Constants.HappinessGestureScale)
            if (happinessChange != 0) {
                happiness += happinessChange
                gesture.setTranslation(CGPointZero, inView: faceView)
            }
        default: break
        }
    }
    func updateUI() {
       faceView?.setNeedsDisplay()
    }
    
     func smilinessForFaceView(sender: FaceView) -> Double? {
        return Double(happiness-50) / 50
    }
    

}
