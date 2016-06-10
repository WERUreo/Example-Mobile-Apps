//
//  Constants.swift
//  werureo-showcase
//
//  Created by Keli'i Martin on 3/13/16.
//  Copyright © 2016 WERUreo. All rights reserved.
//

import Foundation
import UIKit

let SHADOW_COLOR: CGFloat = 157.0 / 255.0

// Keys
let KEY_UID = "uid"

// Segues
let SEGUE_LOGGED_IN = "loggedIn"

// Status Codes
let STATUS_ACCOUNT_NONEXIST = 17011

////////////////////////////////////////////////////////////

func getImageShackAPIKey() -> String?
{
    var keys: NSDictionary?

    if let path = NSBundle.mainBundle().pathForResource("APIKeys", ofType: "plist")
    {
        keys = NSDictionary(contentsOfFile: path)
    }

    if let dict = keys
    {
        let apiKey = dict["imageShackKey"] as? String
        return apiKey
    }

    return nil
}
