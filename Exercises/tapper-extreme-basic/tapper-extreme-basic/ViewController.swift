//
//  ViewController.swift
//  tapper-extreme-basic
//
//  Created by Keli'i Martin on 3/7/16.
//  Copyright © 2016 WERUreo. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    // MARK: - Properties
    var maxTaps = 0
    var currentTaps = 0

    // MARK: - Outlets
    @IBOutlet weak var logoImg: UIImageView!
    @IBOutlet weak var howManyTapsTxt: UITextField!
    @IBOutlet weak var playBtn: UIButton!

    @IBOutlet weak var tapBtn: UIButton!
    @IBOutlet weak var tapsLbl: UILabel!

    ////////////////////////////////////////////////////////////

    @IBAction func onPlayBtnPressed(sender: UIButton!)
    {
        if let numTapsText = howManyTapsTxt?.text,
            let numTaps = Int(numTapsText)
        {
            logoImg.hidden = true
            playBtn.hidden = true
            howManyTapsTxt.hidden = true

            tapBtn.hidden = false
            tapsLbl.hidden = false
            
            maxTaps = numTaps
            currentTaps = 0

            updateTapsLbl()
        }
    }

    ////////////////////////////////////////////////////////////

    @IBAction func onCoinTapped(sender: UIButton)
    {
        currentTaps += 1
        updateTapsLbl()

        if isGameOver()
        {
            restartGame()
        }
    }

    ////////////////////////////////////////////////////////////

    func updateTapsLbl()
    {
        tapsLbl.text = "\(currentTaps) Taps"
    }

    ////////////////////////////////////////////////////////////

    func isGameOver() -> Bool
    {
        return currentTaps >= maxTaps
    }

    ////////////////////////////////////////////////////////////

    func restartGame()
    {
        maxTaps = 0
        howManyTapsTxt.text = ""

        logoImg.hidden = false
        playBtn.hidden = false
        howManyTapsTxt.hidden = false

        tapBtn.hidden = true
        tapsLbl.hidden = true
    }
}

