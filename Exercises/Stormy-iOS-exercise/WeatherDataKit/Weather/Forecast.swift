//
//  Forecast.swift
//  Stormy
//
//  Created by Keli'i Martin on 2/13/16.
//  Copyright © 2016 WERUreo. All rights reserved.
//

import Foundation

public struct Forecast
{
    public var currentWeather: CurrentWeather?
    public var weekly: [DailyWeather] = []

    ////////////////////////////////////////////////////////////

    public init(weatherDictionary: [String: AnyObject]?)
    {
        if let currentWeatherDictionary = weatherDictionary?["currently"] as? [String: AnyObject]
        {
            currentWeather = CurrentWeather(weatherDictionary: currentWeatherDictionary)
        }

        if let weeklyWeatherArray = weatherDictionary?["daily"]?["data"] as? [[String: AnyObject]]
        {
            for dailyWeather in weeklyWeatherArray
            {
                let daily = DailyWeather(dailyWeatherDict: dailyWeather)
                weekly.append(daily)
            }
        }
    }
}