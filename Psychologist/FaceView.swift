//
//  FaceView.swift
//  Happyness
//
//  Created by Iman Rastkhadiv on 30/03/2015.
//  Copyright (c) 2015 Iman Rastkhadiv. All rights reserved.
//

import UIKit

protocol FaceViewDataSource: class{
    func smilinessForFaceView(sender: FaceView) -> Double?
}

@IBDesignable
class FaceView: UIView {
    
    @IBInspectable
    var lineWidth: CGFloat = 3 { didSet { setNeedsDisplay() }}
    @IBInspectable
    var color: UIColor = UIColor.blueColor() { didSet { setNeedsDisplay() }}
    @IBInspectable
    var scale: CGFloat = 0.9 { didSet { setNeedsDisplay() }}
    
    var faceCenter: CGPoint {
        get {
        println("this is the main Center\(center)")
        println(convertPoint(center, fromView: superview))
        println(".........")
        return convertPoint(center, fromView: superview)
        }}
    
    weak var dataSource: FaceViewDataSource?
    
    
    
    var faceRadius: CGFloat {
        
        println(bounds.size) 
        println(frame.size)
        return min(bounds.size.width, bounds.size.height) / 2 * scale
        
    }
    
    private struct Scaling {
        
        static let FaceRadiusToEyeRadiusRatio: CGFloat = 10
        static let FaceRadiusToEyeOffsetRatio: CGFloat = 3
        static let FaceRadiusToEyeSeperationRatio: CGFloat = 1.5
        static let FaceRadiusToMouthWithRatio: CGFloat = 1
        static let FaceRadiusToMouthHeightRatio: CGFloat = 3
        static let FaceRadiusToMouthOffsetRatio: CGFloat = 3
    }
    private enum Eye { case Left, Right }
    private func bazierPathForEye(whichEye: Eye) -> UIBezierPath
    {
        let eyeRadius = faceRadius / Scaling.FaceRadiusToEyeRadiusRatio
        let eyeVerticalOffset = faceRadius / Scaling.FaceRadiusToEyeOffsetRatio
        let eyeHorizantalSeperation = faceRadius / Scaling.FaceRadiusToEyeSeperationRatio
        
        var eyeCenter = faceCenter
        eyeCenter.y -= eyeVerticalOffset
        switch whichEye {
        case .Left: eyeCenter.x -= eyeHorizantalSeperation / 2
        case .Right: eyeCenter.x += eyeHorizantalSeperation / 2
        }
        let path = UIBezierPath(arcCenter: eyeCenter, radius: eyeRadius, startAngle: 0, endAngle: CGFloat(2*M_PI), clockwise: true)
        path.lineWidth = lineWidth
        return path
    }
    private func bazierPathForSmile(fractionOfMaxSmile: Double) -> UIBezierPath {
        
        let mouthWidth = faceRadius / Scaling.FaceRadiusToMouthWithRatio
        let mouthHeight = faceRadius / Scaling.FaceRadiusToMouthHeightRatio
        let mouthVerticalOffset = faceRadius / Scaling.FaceRadiusToMouthOffsetRatio
        let smileHeight = CGFloat(max(min(fractionOfMaxSmile, 1), -1)) * mouthHeight
        
        let start = CGPoint(x: faceCenter.x - mouthWidth / 2, y: faceCenter.y + mouthVerticalOffset)
        let end = CGPoint(x: start.x + mouthWidth, y: start.y)
        let cp1 = CGPoint(x: start.x + mouthWidth / 3, y: start.y + smileHeight)
        let cp2 = CGPoint(x: end.x - mouthWidth / 3, y: cp1.y)
        
        let path = UIBezierPath()
        path.moveToPoint(start)
        path.addCurveToPoint(end, controlPoint1: cp1, controlPoint2: cp2)
        path.lineWidth = lineWidth
        
        return path
        
    }
    
    func scale(gesture: UIPinchGestureRecognizer) {
        if gesture.state == .Changed {
            
            scale *= gesture.scale
            gesture.scale = 1 
        }
    }
    override func drawRect(rect: CGRect) {
        
        let facePath = UIBezierPath(arcCenter: faceCenter, radius: faceRadius, startAngle: 0, endAngle: CGFloat(2*M_PI), clockwise: true)
        facePath.lineWidth = lineWidth
        color.set()
        facePath.stroke()
        
        UIColor.redColor().set()
        bazierPathForEye(.Left).fill()
        bazierPathForEye(.Right).fill()
        bazierPathForEye(.Left).stroke()
        bazierPathForEye(.Right).stroke()
        
//        let smiliness = 0.75
        let smiliness = dataSource?.smilinessForFaceView(self) ?? 0.0
        let smilePath = bazierPathForSmile(smiliness)
        smilePath.stroke()
    }


}
