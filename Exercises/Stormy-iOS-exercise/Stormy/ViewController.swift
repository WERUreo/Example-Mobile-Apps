//
//  ViewController.swift
//  Stormy
//
//  Created by Keli'i Martin on 1/28/16.
//  Copyright © 2016 WERUreo. All rights reserved.
//

import UIKit
import CoreLocation
import WeatherDataKit

class ViewController: UIViewController, CLLocationManagerDelegate
{
    // MARK: - Properties

    var dailyWeather: DailyWeather?
    {
        didSet
        {
            configureView()
        }
    }

    @IBOutlet weak var weatherIcon: UIImageView?
    @IBOutlet weak var summaryLabel: UILabel?
    @IBOutlet weak var sunriseTimeLabel: UILabel?
    @IBOutlet weak var sunsetTimeLabel: UILabel?

    @IBOutlet weak var lowTemperatureLabel: UILabel?
    @IBOutlet weak var highTemperatureLabel: UILabel?
    @IBOutlet weak var precipitationLabel: UILabel?
    @IBOutlet weak var humidityLabel: UILabel?

    ////////////////////////////////////////////////////////////

    override func viewDidLoad()
    {
        super.viewDidLoad()
        configureView()
    }

    ////////////////////////////////////////////////////////////

    func configureView()
    {
        if let weather = dailyWeather
        {
            self.title = weather.day
            // Update UI with information from the data model
            weatherIcon?.image = weather.largeIcon
            summaryLabel?.text = weather.summary
            sunriseTimeLabel?.text = weather.sunriseTime
            sunsetTimeLabel?.text = weather.sunsetTime

            if let lowTemp = weather.minTemperature,
                let highTemp = weather.maxTemperature,
                let rain = weather.precipChance,
                let humidity = weather.humidity
            {
                lowTemperatureLabel?.text = "\(lowTemp)º"
                highTemperatureLabel?.text = "\(highTemp)º"
                precipitationLabel?.text = "\(rain)%"
                humidityLabel?.text = "\(humidity)%"
            }
        }

        // Configure nav bar back button
        if let buttonFont = UIFont(name: "HelveticaNeue-Thin", size: 20.0)
        {
            let barButtonAttributesDictionary: [String: AnyObject]? = [
                NSForegroundColorAttributeName: UIColor.whiteColor(),
                NSFontAttributeName: buttonFont
            ]
            UIBarButtonItem.appearance().setTitleTextAttributes(barButtonAttributesDictionary, forState: .Normal)
        }
    }

    ////////////////////////////////////////////////////////////

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    ////////////////////////////////////////////////////////////
}

