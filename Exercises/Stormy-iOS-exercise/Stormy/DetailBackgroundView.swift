//
//  DetailBackgroundView.swift
//  Stormy
//
//  Created by Keli'i Martin on 2/13/16.
//  Copyright © 2016 WERUreo. All rights reserved.
//

import UIKit

@IBDesignable
class DetailBackgroundView: UIView
{
    @IBInspectable var lightColor: UIColor = UIColor(red: 110/255.0, green: 181/255.0, blue: 232/255.0, alpha: 1.000)
    @IBInspectable var darkColor: UIColor = UIColor(red: 13/255.0, green: 97/255.0, blue: 196/255.0, alpha: 1.000)
    @IBInspectable var pathStrokeColor: UIColor = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 0.390)
    @IBInspectable var pathFillColor: UIColor = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 0.100)

    override func drawRect(rect: CGRect)
    {
        let context = UIGraphicsGetCurrentContext()

        //// Gradient Declarations
        let gradient = CGGradientCreateWithColors(CGColorSpaceCreateDeviceRGB(), [lightColor.CGColor, darkColor.CGColor], [0, 1])

        //// Background Drawing
        let backgroundPath = UIBezierPath(rect: CGRectMake(0, 0, self.frame.width, self.frame.height))
        CGContextSaveGState(context)
        backgroundPath.addClip()
        CGContextDrawLinearGradient(context, gradient,
            CGPointMake(160, 0),
            CGPointMake(160, 568),
            [.DrawsBeforeStartLocation, .DrawsAfterEndLocation])
        CGContextRestoreGState(context)

        //// Sun Path
        let circleOrigin = CGPointMake(0, 0.80 * self.frame.height)
        let circleSize = CGSizeMake(self.frame.width, 0.65 * self.frame.height)

        //// Sun Drawing
        let sunPath = UIBezierPath(ovalInRect: CGRectMake(circleOrigin.x, circleOrigin.y, circleSize.width, circleSize.height))
        pathFillColor.setFill()
        sunPath.fill()
        pathStrokeColor.setStroke()
        sunPath.lineWidth = 1
        CGContextSaveGState(context)
        CGContextSetLineDash(context, 0, [2, 2], 2)
        sunPath.stroke()
        CGContextRestoreGState(context)
    }


}
