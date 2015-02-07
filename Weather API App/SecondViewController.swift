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
//println("to pass: ")
//println(self.toPass)

        var error: NSError? = nil
        var weatherObj: NSDictionary? = NSJSONSerialization.JSONObjectWithData(WeatherResults as NSData, options: NSJSONReadingOptions.allZeros, error: &error) as? NSDictionary

println(weatherObj)
        
        //No data returned
        if weatherObj == nil {
            self.cityNameLabel.text = "No Data At This Time"
            self.tempLabel.text = ""
            self.descriptionLabel.text = ""
            self.windSpeedLabel.text = ""
        }
        //Small check to verify api results have a code
        else if weatherObj?["cod"] != nil && weatherObj?["cod"]! != nil{
            
            //println((weatherObj?["cod"]!)!)
            var code: NSInteger = ((weatherObj?["cod"]!)!).integerValue
println("Response Code: \(code)")
            
            if code == 404 && weatherObj?["message"] != nil {
                
                var message: String? = "City Not Found"
                println(message!)
                if message != nil {
                    self.cityNameLabel.text = message!
                }
                else {
                    self.cityNameLabel.text = "No Error Message...Not Helpful"
                }
                self.tempLabel.text = ""
                self.descriptionLabel.text = ""
                self.windSpeedLabel.text = ""
                
            }
            else if code == 200 {
                
                //Get city name from response
                if weatherObj?["name"] != nil {
                    var cityName: AnyObject? = weatherObj?["name"]
                    var stateCode = self.toPass["stateCode"]
println("City Name: \(cityName!)")
                    self.cityNameLabel.text = "Currently in \(cityName! as NSString), \(stateCode!)"
                }
                
                //Get temperature from response
                if weatherObj?["main"]?["temp"] != nil {
                    var temperature: String? = String(format: "%.2f", (weatherObj?["main"]?["temp"]! as? Double)!)
println("Temp: \(temperature!)")
                    self.tempLabel.text = "Temp: \(temperature!)F"
                }
                
                //Get short weather description from response
                if weatherObj?["weather"]?.firstObject != nil {
                    var description: AnyObject? = (weatherObj?["weather"]?.firstObject as? NSDictionary)?["description"]
println("Description: \(description!)")
                    self.descriptionLabel.text = (description! as NSString).uppercaseString
                }
                
                //Get wind speed from response
                if weatherObj?["wind"]?["speed"] != nil {
                    var windSpeed: AnyObject? = weatherObj?["wind"]?["speed"]!
println("Wind Speed: \(windSpeed!)")
                    self.windSpeedLabel.text = "Wind Speed: \(windSpeed!)"
                }
                
            }
            else {
                self.cityNameLabel.text = "No Data At This Time"
                self.tempLabel.text = ""
                self.descriptionLabel.text = ""
                self.windSpeedLabel.text = ""
            }
        }
        //WE have api results but they are in an unrecognized format
        else {
            self.cityNameLabel.text = "Bad Response From Weather Service"
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