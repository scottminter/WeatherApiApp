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
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var windGustLabel: UILabel!
    
    
    override func viewDidAppear(animated: Bool) {
        println("I appeared")
        //println(WeatherResults)
        var error: NSError? = nil
        var jsonResults: AnyObject? = NSJSONSerialization.JSONObjectWithData(WeatherResults as NSData, options: NSJSONReadingOptions.allZeros, error: &error)

        //println(jsonResults!)
        var weatherObj: NSDictionary? = jsonResults! as? NSDictionary
        println(weatherObj!)
        
        var cityName: AnyObject? = weatherObj?["name"]
println(cityName!)
        var temperature: Double? = weatherObj?["main"]?["temp"]! as? Double
        var tempStr: String = String(format:"%f", temperature!)
println(tempStr)
        var description: AnyObject? = (weatherObj?["weather"]?.firstObject as? NSDictionary)?["description"]
println(description!)
        var windSpeed: AnyObject? = weatherObj?["wind"]?["speed"]!
println(windSpeed!)
        var windGust: AnyObject? = weatherObj?["wind"]?["gust"]!
println(windGust!)
        
        self.cityNameLabel.text = cityName! as NSString
        self.tempLabel.text = tempStr //temperature as? NSString as? String
        self.descriptionLabel.text = description! as NSString
    
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        println("Do someting")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}