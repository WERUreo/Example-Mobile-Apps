//
//  ViewController.swift
//  Section-02-Exercise-01
//
//  Created by Keli'i Martin on 3/1/16.
//  Copyright © 2016 WERUreo. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    @IBOutlet weak var redCircle: UIImageView?
    @IBOutlet weak var blueCircle: UIImageView?
    @IBOutlet weak var hideBlueCircleButton: UIButton?
    @IBOutlet weak var hideRedCircleButton: UIButton?

    ////////////////////////////////////////////////////////////

    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    ////////////////////////////////////////////////////////////

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    ////////////////////////////////////////////////////////////

    @IBAction func hideBlueCircle(sender: AnyObject)
    {
        if let circle = blueCircle,
            let button = hideBlueCircleButton
        {
            circle.hidden = !circle.hidden
            let titleString = circle.hidden ? "Show Blue Circle" : "Hide Blue Circle"
            button.setTitle(titleString, forState: .Normal)
        }
    }

    ////////////////////////////////////////////////////////////

    @IBAction func hideRedCircle(sender: AnyObject)
    {
        if let circle = redCircle,
            let button = hideRedCircleButton
        {
            circle.hidden = !circle.hidden
            let titleString = circle.hidden ? "Show Red Circle" : "Hide Red Circle"
            button.setTitle(titleString, forState: .Normal)
        }
    }
}

