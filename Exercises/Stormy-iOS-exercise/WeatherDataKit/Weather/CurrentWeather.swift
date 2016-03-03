//
//  CurrentWeather.swift
//  Stormy
//
//  Created by Keli'i Martin on 1/28/16.
//  Copyright © 2016 WERUreo. All rights reserved.
//

import Foundation
import UIKit

public struct CurrentWeather
{
    public let temperature: Int?
    public let humidity: Int?
    public let precipProbability: Int?
    public let summary: String?
    public var time: String?
    public var icon: UIImage? = UIImage(named: "default.png")
    private let formatter = NSDateFormatter()

    ////////////////////////////////////////////////////////////

    public init(weatherDictionary: [String: AnyObject])
    {
        temperature = weatherDictionary["temperature"] as? Int

        if let humidityFloat = weatherDictionary["humidity"] as? Double
        {
            humidity = Int(humidityFloat * 100)
        }
        else
        {
            humidity = nil
        }

        if let precipFloat = weatherDictionary["precipProbability"] as? Double
        {
            precipProbability = Int(precipFloat * 100)
        }
        else
        {
            precipProbability = nil
        }

        summary = weatherDictionary["summary"] as? String

        if let currentTime = weatherDictionary["time"] as? Double
        {
            time = timeStringFromUnixTime(currentTime)
        }
        else
        {
            time = nil
        }

        if let iconString = weatherDictionary["icon"] as? String,
            let weatherIcon: Icon = Icon(rawValue: iconString)
        {
            (icon, _) = weatherIcon.toImage()
        }
    }

    ////////////////////////////////////////////////////////////

    internal func timeStringFromUnixTime(unixTime: Double) -> String
    {
        let date = NSDate(timeIntervalSince1970: unixTime)

        // Returns date formatted as 12 hour time.
        formatter.dateFormat = "hh:mm a"
        return formatter.stringFromDate(date)
    }
    

}