//
//  TodayViewController.swift
//  WeatherToday
//
//  Created by Keli'i Martin on 2/15/16.
//  Copyright © 2016 WERUreo. All rights reserved.
//

import UIKit
import NotificationCenter
import CoreLocation
import WeatherDataKit

class TodayViewController: UIViewController, NCWidgetProviding, CLLocationManagerDelegate
{
    // MARK: - NSUserDefaults keys

    let iconKey = "CURRENT_ICON"
    let temperatureKey = "CURRENT_TEMPERATURE"
    let locationKey = "CURRENT_LOCATION"
    let summaryKey = "CURRENT_SUMMARY"

    // MARK: - Properties

    @IBOutlet weak var iconImageView: UIImageView?
    @IBOutlet weak var temperatureLabel: UILabel?
    @IBOutlet weak var locationLabel: UILabel?
    @IBOutlet weak var summaryLabel: UILabel?

    var locationManager: CLLocationManager!

    var coordinate: (lat: Double, long: Double) = (37.8367, -122.423)

    var defaults = NSUserDefaults.standardUserDefaults()

    ////////////////////////////////////////////////////////////

    override func viewDidLoad()
    {
        super.viewDidLoad()

        self.preferredContentSize = CGSizeMake(0.0, 70.0)

        // Weather data should default to last known weather data, if it exists.
        // Otherwise, use some defaults

        if let icon = defaults.objectForKey(iconKey)
        {
            iconImageView?.image = icon as? UIImage
        }
        else
        {
            iconImageView?.image = UIImage(named: "default")
        }

        if let temperature = defaults.stringForKey(temperatureKey)
        {
            temperatureLabel?.text = temperature
        }
        else
        {
            temperatureLabel?.text = "--º"
        }

        if let location = defaults.stringForKey(locationKey)
        {
            locationLabel?.text = location
        }
        else
        {
            locationLabel?.text = ""
        }

        if let summary = defaults.stringForKey(summaryKey)
        {
            summaryLabel?.text = summary
        }
        else
        {
            summaryLabel?.text = ""
        }

        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()

        // use tap gesture to launch app
        let tapGesture = UITapGestureRecognizer(target: self, action: Selector("doLaunchApp"))

        iconImageView?.userInteractionEnabled = true;
        iconImageView?.addGestureRecognizer(tapGesture)

    }

    ////////////////////////////////////////////////////////////

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    ////////////////////////////////////////////////////////////

    func widgetMarginInsetsForProposedMarginInsets(defaultMarginInsets: UIEdgeInsets) -> UIEdgeInsets
    {
        var margins = defaultMarginInsets
        margins.bottom = 8.0
        return margins
    }

    ////////////////////////////////////////////////////////////

    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void))
    {
        locationManager.startUpdatingLocation()
        retrieveWeatherForecast()
        completionHandler(NCUpdateResult.NewData)
    }

    ////////////////////////////////////////////////////////////

    func retrieveWeatherForecast()
    {
        guard let apiKey = getAPIKey() else
        {
            fatalError("Could not find API key.")
        }

        let forecastService = ForecastService(APIKey: apiKey)
        forecastService.getForecast(coordinate.lat, long: coordinate.long) {
            (let forecast) -> Void in
            if let weatherForecast = forecast,
                let currentWeather = weatherForecast.currentWeather
            {
                // update UI
                dispatch_async(dispatch_get_main_queue()) {
                    // Execute closure
                    if let temperature = currentWeather.temperature
                    {
                        self.temperatureLabel?.text = "\(temperature)º"
                        self.defaults.setObject("\(temperature)º", forKey: self.temperatureKey)
                    }

                    self.iconImageView?.image = currentWeather.icon
                    let iconPNG = UIImagePNGRepresentation(currentWeather.icon!)
                    self.defaults.setObject(iconPNG, forKey: self.iconKey)

                    self.summaryLabel?.text = currentWeather.summary
                    self.defaults.setObject(currentWeather.summary, forKey: self.summaryKey)
                }
            }
        }
    }

    ////////////////////////////////////////////////////////////

    func getAPIKey() -> String?
    {
        var keys: NSDictionary?

        if let path = NSBundle.mainBundle().pathForResource("APIKey", ofType: "plist")
        {
            keys = NSDictionary(contentsOfFile: path)
        }

        if let dict = keys
        {
            let apiKey = dict["forecastAPIKey"] as? String
            return apiKey
        }

        return nil
    }

    ////////////////////////////////////////////////////////////
    
    // MARK: - Location

    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        var placemark: CLPlacemark!
        locationManager.stopUpdatingLocation()

        if let currentLocation = manager.location
        {
            coordinate.lat = currentLocation.coordinate.latitude
            coordinate.long = currentLocation.coordinate.longitude

            retrieveWeatherForecast()

            CLGeocoder().reverseGeocodeLocation(manager.location!) { (placemarks, error) -> Void in
                if error == nil && placemarks!.count > 0
                {
                    placemark = placemarks![0] as CLPlacemark
                    let locationName = "\(placemark.locality!), \(placemark.administrativeArea!)"
                    self.locationLabel?.text = locationName
                    self.defaults.setObject(locationName, forKey: self.locationKey)
                }
            }
        }
    }

    ////////////////////////////////////////////////////////////

    func locationManager(manager: CLLocationManager, didFailWithError error: NSError)
    {
        print("\(error)")
    }

    ////////////////////////////////////////////////////////////

    func doLaunchApp()
    {
        if let url = NSURL(string: "Stormy://")
        {
            self.extensionContext?.openURL(url, completionHandler: nil)
        }
    }
}
