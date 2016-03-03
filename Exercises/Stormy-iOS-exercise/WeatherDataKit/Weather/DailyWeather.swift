//
//  DailyWeather.swift
//  Stormy
//
//  Created by Keli'i Martin on 2/12/16.
//  Copyright © 2016 WERUreo. All rights reserved.
//

import Foundation
import UIKit

public struct DailyWeather
{
    public let maxTemperature: Int?
    public let minTemperature: Int?
    public let humidity: Int?
    public let precipChance: Int?
    public let summary: String?
    public var icon: UIImage? = UIImage(named: "default.png")
    public var largeIcon: UIImage? = UIImage(named: "default_large.png")
    public var sunriseTime: String?
    public var sunsetTime: String?
    public var day: String?
    private let dateFormatter = NSDateFormatter()

    ////////////////////////////////////////////////////////////

    public init(dailyWeatherDict: [String: AnyObject])
    {
        maxTemperature = dailyWeatherDict["temperatureMax"] as? Int
        minTemperature = dailyWeatherDict["temperatureMin"] as? Int

        if let humidityFloat = dailyWeatherDict["humidity"] as? Double
        {
            humidity = Int(humidityFloat * 100)
        }
        else
        {
            humidity = nil
        }

        if let precipChanceFloat = dailyWeatherDict["precipProbability"] as? Double
        {
            precipChance = Int(precipChanceFloat * 100)
        }
        else
        {
            precipChance = nil
        }

        summary = dailyWeatherDict["summary"] as? String

        if let iconString = dailyWeatherDict["icon"] as? String,
            let iconEnum = Icon(rawValue: iconString)
        {
            (icon, largeIcon) = iconEnum.toImage()
        }

        if let sunriseDate = dailyWeatherDict["sunriseTime"] as? Double
        {
            sunriseTime = timeStringFromUnixTime(sunriseDate)
        }
        else
        {
            sunriseTime = nil
        }

        if let sunsetDate = dailyWeatherDict["sunsetTime"] as? Double
        {
            sunsetTime = timeStringFromUnixTime(sunsetDate)
        }
        else
        {
            sunsetTime = nil
        }

        if let time = dailyWeatherDict["time"] as? Double
        {
            day = dayStringFromTime(time)
        }
    }

    ////////////////////////////////////////////////////////////

    internal func timeStringFromUnixTime(unixTime: Double) -> String
    {
        let date = NSDate(timeIntervalSince1970: unixTime)

        // Returns date formatted as 12 hour time.
        dateFormatter.dateFormat = "hh:mm a"
        return dateFormatter.stringFromDate(date)
    }

    ////////////////////////////////////////////////////////////

    internal func dayStringFromTime(time: Double) -> String
    {
        let date = NSDate(timeIntervalSince1970: time)

        dateFormatter.locale = NSLocale(localeIdentifier: NSLocale.currentLocale().localeIdentifier)
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.stringFromDate(date)
    }
}