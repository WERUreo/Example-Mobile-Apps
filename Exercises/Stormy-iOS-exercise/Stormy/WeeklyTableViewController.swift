//
//  WeeklyTableViewController.swift
//  Stormy
//
//  Created by Keli'i Martin on 2/12/16.
//  Copyright © 2016 WERUreo. All rights reserved.
//

import UIKit
import CoreLocation
import WeatherDataKit

class WeeklyTableViewController: UITableViewController, CLLocationManagerDelegate
{
    // MARK: - Properties
    
    @IBOutlet weak var currentTemperatureLabel: UILabel?
    @IBOutlet weak var currentWeatherIcon: UIImageView?
    @IBOutlet weak var currentPrecipitationLabel: UILabel?
    @IBOutlet weak var currentTemperatureRangeLabel: UILabel?
    @IBOutlet weak var currentLocationLabel: UILabel?
    @IBOutlet weak var currentTimeLabel: UILabel?

    var locationManager: CLLocationManager!

    var coordinate: (lat: Double, long: Double) = (37.8367, -122.423)

    var weeklyWeather: [DailyWeather] = []

    ////////////////////////////////////////////////////////////

    override func viewDidLoad()
    {
        super.viewDidLoad()

        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()

        configureView()
        retrieveWeatherForecast()
    }

    ////////////////////////////////////////////////////////////

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    ////////////////////////////////////////////////////////////

    func configureView()
    {
        // Set table view's background view property
        //tableView.backgroundView = BackgroundView()

        // Set custom height for table view row
        tableView.rowHeight = 64

        // Change the font and size of nav bar text
        if let navBarFont = UIFont(name: "HelveticaNeue-Thin", size: 20.0)
        {
            let navBarAttributesDictionary: [String: AnyObject]? = [
                NSForegroundColorAttributeName: UIColor.whiteColor(),
                NSFontAttributeName: navBarFont
            ]

            navigationController?.navigationBar.titleTextAttributes = navBarAttributesDictionary
        }

        refreshControl?.tintColor = UIColor.whiteColor()
    }

    ////////////////////////////////////////////////////////////

    @IBAction func refreshWeather()
    {
        locationManager.startUpdatingLocation()
        refreshControl?.endRefreshing()
    }

    ////////////////////////////////////////////////////////////

    override func preferredStatusBarStyle() -> UIStatusBarStyle
    {
        return .LightContent
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

    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "showDaily"
        {
            if let indexPath = tableView.indexPathForSelectedRow
            {
                let dailyWeather = weeklyWeather[indexPath.row]

                (segue.destinationViewController as! ViewController).dailyWeather = dailyWeather
            }
        }
    }

    ////////////////////////////////////////////////////////////
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }

    ////////////////////////////////////////////////////////////

    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        return "Forecast"
    }

    ////////////////////////////////////////////////////////////

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return weeklyWeather.count
    }

    ////////////////////////////////////////////////////////////

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("WeatherCell") as! DailyWeatherTableViewCell

        let dailyWeather: DailyWeather = weeklyWeather[indexPath.row]
        if let maxTemp = dailyWeather.maxTemperature
        {
            cell.temperatureLabel.text = "\(maxTemp)º"
        }
        cell.weatherIcon.image = dailyWeather.icon
        cell.dayLabel.text = dailyWeather.day

        return cell
    }

    ////////////////////////////////////////////////////////////

    // MARK: - Table View Delegate

    override func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int)
    {
        view.tintColor = UIColor(red: 110/255.0, green: 181/255.0, blue: 232/255.0, alpha: 1.0)

        if let header = view as? UITableViewHeaderFooterView
        {
            header.textLabel?.font = UIFont(name: "HelveticaNeue-Thin", size: 14.0)
            header.textLabel?.textColor = UIColor.whiteColor()
        }
    }

    ////////////////////////////////////////////////////////////

    override func tableView(tableView: UITableView, didHighlightRowAtIndexPath indexPath: NSIndexPath)
    {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        cell?.contentView.backgroundColor = UIColor(red: 110/255.0, green: 181/255.0, blue: 232/255.0, alpha: 1.0)
        let highlightView = UIView()
        highlightView.backgroundColor = UIColor(red: 110/255.0, green: 181/255.0, blue: 232/255.0, alpha: 1.0)
        cell?.selectedBackgroundView = highlightView
    }

    ////////////////////////////////////////////////////////////

    // MARK: - Weather Fetching

    func retrieveWeatherForecast()
    {
        guard let apiKey = getAPIKey() else
        {
            fatalError("Could not find an API key.  Make sure you have an APIKey.plist file that contains your API key")
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
                        self.currentTemperatureLabel?.text = "\(temperature)º"
                    }
                    if let precipitation = currentWeather.precipProbability
                    {
                        self.currentPrecipitationLabel?.text = "Rain: \(precipitation)%"
                    }
                    if let icon = currentWeather.icon
                    {
                        self.currentWeatherIcon?.image = icon
                    }

                    self.weeklyWeather = weatherForecast.weekly

                    if let highTemp = self.weeklyWeather.first?.maxTemperature,
                        let lowTemp = self.weeklyWeather.first?.minTemperature
                    {
                        self.currentTemperatureRangeLabel?.text = "↑\(highTemp)º↓\(lowTemp)º"
                    }

                    if let time = currentWeather.time
                    {
                        self.currentTimeLabel?.text = "At \(time) the weather will be"
                    }

                    self.tableView.reloadData()
                }
            }
        }
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
                    self.currentLocationLabel?.text = locationName
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

    func displayLocationInfo(placemark: CLPlacemark)
    {
        locationManager.stopUpdatingLocation()
    }
}
