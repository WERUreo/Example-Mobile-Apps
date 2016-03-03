//
//  ViewController.swift
//  Animations
//
//  Created by Keli'i Martin on 1/27/16.
//  Copyright © 2016 WERUreo. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{

    @IBOutlet var alienImage: UIImageView!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    override func viewDidLayoutSubviews()
    {
        alienImage.frame = CGRectMake(100, 20, 0, 0)
    }

    override func viewDidAppear(animated: Bool)
    {
        UIView.animateWithDuration(1) { () -> Void in
            self.alienImage.frame = CGRectMake(100, 20, 100, 200)
        }
    }

*/
    @IBAction func updateImage(sender: AnyObject)
    {
        alienImage.image = UIImage(named: "frame5.png")
        print("Button clicked")
    }
}

