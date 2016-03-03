//
//  BackgroundView.swift
//  Stormy
//
//  Created by Keli'i Martin on 2/12/16.
//  Copyright © 2016 WERUreo. All rights reserved.
//

import UIKit

@IBDesignable
class BackgroundView: UITableView
{
    @IBInspectable var lightColor: UIColor = UIColor(red: 110/255.0, green: 181/255.0, blue: 232/255.0, alpha: 1.000)
    {
        didSet
        {
            setNeedsDisplay()
        }
    }
    @IBInspectable var darkColor: UIColor = UIColor(red: 13/255.0, green: 97/255.0, blue: 196/255.0, alpha: 1.000)
    {
        didSet
        {
            setNeedsDisplay()
        }
    }

    override func drawRect(rect: CGRect)
    {
        // Background View

        //// Color Declarations
        //let lightBlue: UIColor = UIColor(red: 110/255.0, green: 181/255.0, blue: 232/255.0, alpha: 1.000)
        //let darkBlue: UIColor = UIColor(red: 13/255.0, green: 97/255.0, blue: 196/255.0, alpha: 1.000)

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
    }
}
