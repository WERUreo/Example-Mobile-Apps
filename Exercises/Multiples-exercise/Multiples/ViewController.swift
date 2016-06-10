//
//  ViewController.swift
//  Multiples
//
//  Created by Keli'i Martin on 3/7/16.
//  Copyright © 2016 WERUreo. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    // MARK: - Properties
    var multiple = 0
    var startingNum = 0
    let maxTaps = 10
    var numTaps = 0

    // MARK: - Outlets
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var multiplesTextField: UITextField!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var addLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!

    ////////////////////////////////////////////////////////////

    @IBAction func playGame(sender: UIButton)
    {
        if let multiplesText = multiplesTextField?.text,
            let multipleNum = Int(multiplesText)
        {
            logoImage.hidden = true
            multiplesTextField.hidden = true
            playButton.hidden = true
            addLabel.hidden = false
            addButton.hidden = false
            
            multiple = multipleNum
            addLabel.text = "Press Add to add!"
        }
    }

    ////////////////////////////////////////////////////////////

    @IBAction func addMultiple(sender: UIButton)
    {
        let sum = startingNum + multiple
        addLabel.text = "\(startingNum) + \(multiple) = \(sum)"
        startingNum = sum

        numTaps += 1

        if isGameOver()
        {
            restartGame()
        }
    }

    ////////////////////////////////////////////////////////////

    func isGameOver() -> Bool
    {
        return numTaps == maxTaps
    }

    ////////////////////////////////////////////////////////////

    func restartGame()
    {
        multiplesTextField.text = ""
        startingNum = 0
        numTaps = 0
        
        logoImage.hidden = false
        multiplesTextField.hidden = false
        playButton.hidden = false
        addLabel.hidden = true
        addButton.hidden = true
    }
}

