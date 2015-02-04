//
//  SecondViewController.swift
//  Weather API App
//
//  Created by Scott Minter on 2/2/15.
//  Copyright (c) 2015 Scott Minter Designs. All rights reserved.
//

import Foundation
import UIKit

class SecondViewController: UIViewController {
    
    var toPass: Dictionary<String, String>!
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    
    
    override func viewDidAppear(animated: Bool) {
println("to pass: ")
println(self.toPass)
//println(WeatherResults)
        var error: NSError? = nil
        var jsonResults: AnyObject? = NSJSONSerialization.JSONObjectWithData(WeatherResults as NSData, options: NSJSONReadingOptions.allZeros, error: &error)

        if jsonResults != nil {
            
            //Cast results to NSDictionary
            var weatherObj: NSDictionary? = (jsonResults! as NSDictionary)
println(weatherObj!)
            
            //Get city name from response
            if weatherObj?["name"] != nil {
                var cityName: AnyObject? = weatherObj?["name"]
                var stateCode = self.toPass["stateCode"]
println(cityName!)
                self.cityNameLabel.text = "Currently in \(cityName! as NSString), \(stateCode!)"
            }
            
            //Get temperature from response
            if weatherObj?["main"]?["temp"] != nil {
                var temperature: String? = String(format: "%.2f", (weatherObj?["main"]?["temp"]! as? Double)!)
println(temperature!)
                self.tempLabel.text = "Temp: \(temperature!)F"
            }
            
            
            //Get short weather description from response
            if weatherObj?["weather"]?.firstObject != nil {
                var description: AnyObject? = (weatherObj?["weather"]?.firstObject as? NSDictionary)?["description"]
println(description!)
                self.descriptionLabel.text = (description! as NSString).uppercaseString
            }
            
            //Get wind speed from response
            if weatherObj?["wind"]?["speed"] != nil {
                var windSpeed: AnyObject? = weatherObj?["wind"]?["speed"]!
println(windSpeed!)
                self.windSpeedLabel.text = "Wind Speed: \(windSpeed!)"
            }
            
        }
        else {
            println("No Data came back")
            self.cityNameLabel.text = "No Data at this Time"
            self.tempLabel.text = ""
            self.descriptionLabel.text = ""
            self.windSpeedLabel.text = ""
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}