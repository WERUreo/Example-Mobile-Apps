//
//  ForecastService.swift
//  Stormy
//
//  Created by Keli'i Martin on 1/28/16.
//  Copyright © 2016 WERUreo. All rights reserved.
//

import Foundation

public class ForecastService
{
    let forecastAPIKey: String
    let forecastBaseURL: NSURL?

    ////////////////////////////////////////////////////////////

    public init(APIKey: String)
    {
        forecastAPIKey = APIKey
        forecastBaseURL = NSURL(string: "https://api.forecast.io/forecast/\(forecastAPIKey)/")
    }

    ////////////////////////////////////////////////////////////

    public func getForecast(lat: Double, long: Double, completion: (Forecast? -> Void))
    {
        if let forecastURL = NSURL(string: "\(lat),\(long)", relativeToURL: forecastBaseURL)
        {
            let networkOperation = NetworkOperation(url: forecastURL)
            networkOperation.downloadJSONFromURL { (let JSONDictionary) in
                let forecast = Forecast(weatherDictionary: JSONDictionary)
                completion(forecast)
            }
        }
        else
        {
            print("Could not construct a valid URL")
        }
    }
}