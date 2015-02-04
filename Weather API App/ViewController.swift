//
//  ViewController.swift
//  Weather API App
//
//  Created by Scott Minter on 2/2/15.
//  Copyright (c) 2015 Scott Minter Designs. All rights reserved.
//

import UIKit

var WeatherResults = NSData()

class ViewController: UIViewController {
    
    var WeatherUrl: String = "http://api.openweathermap.org/data/2.5/weather?q=[CITY],[STATE],US&units=imperial"
    var ApiError: Bool = false
    var cityName = String()
    var stateCode = String()

    @IBOutlet weak var cityInput: UITextField!
    @IBOutlet weak var stateInput: UITextField!
    
    @IBAction func submitButton(sender: AnyObject) {
println("SBUMIT")
        /**
         * We gotta put the URL together first
         */
        
        //get city name and remove beginning and ending whitespaces
        self.cityName = cityInput.text.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        self.cityName = self.cityName.stringByReplacingOccurrencesOfString(" ", withString: "+", options: NSStringCompareOptions.LiteralSearch, range: nil)

        //get state code and remove beginning and ending whitespaces
        self.stateCode = stateInput.text.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        self.stateCode = self.stateCode.uppercaseString
        
        //Insert city name into URL
        var urlWithCity = String()
        if !cityName.isEmpty {
            urlWithCity = self.WeatherUrl.stringByReplacingOccurrencesOfString("[CITY]", withString: self.cityName, options: NSStringCompareOptions.LiteralSearch, range: nil)
            self.WeatherUrl = urlWithCity
        }
        
        //Insert state code into URL
        var urlWithCityAndState = String()
        if !stateCode.isEmpty {
            urlWithCityAndState = self.WeatherUrl.stringByReplacingOccurrencesOfString("[STATE]", withString: self.stateCode, options: NSStringCompareOptions.LiteralSearch, range: nil)
            self.WeatherUrl = urlWithCityAndState
        }
        
println(self.WeatherUrl)
        
        /**
         * Now lets get some weather
         */
        let url = NSURL(string: self.WeatherUrl)

        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {
            (data, response, error) in
            
            if error == nil {
                var info = data

                dispatch_async(dispatch_get_main_queue()) {
                    WeatherResults = info!
                }
            }
            else {
                self.ApiError = true
                println("Error: \(error)")
            }
        }
        
        //I don't want to segue until the data has arrived.  
        //Is this the correct way to do that?
        task.resume( performSegueWithIdentifier("segue1", sender: self))
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
println("SEGUE")
        if segue.identifier == "segue1" {
            var svc = segue.destinationViewController as SecondViewController
            
            var locationObj = Dictionary<String, String>()
            locationObj["cityName"] = self.cityName
            locationObj["stateCode"] = self.stateCode
            
            svc.toPass = locationObj
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        println("City Name: \(self.cityName)")
        println("State Code: \(self.stateCode)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //self.cityInput.text = "Newport News"
        //self.stateInput.text = "va"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //THIS FUNCITON CAN PREVENT THE SEGUE TO THE SECOND VIEW CONTROLLER
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
       
        if cityInput.text.isEmpty || cityInput.text.isEmpty {
            return false
        }
        else {
            return true
        }

        //return false

    }

}

