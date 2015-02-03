//
//  ViewController.swift
//  Weather API App
//
//  Created by Scott Minter on 2/2/15.
//  Copyright (c) 2015 Scott Minter Designs. All rights reserved.
//

import UIKit

var WeatherResults = NSData() //String()

class ViewController: UIViewController {
    
    var WeatherUrl: String = "http://api.openweathermap.org/data/2.5/weather?q=[CITY],[STATE],US&units=imperial"

    @IBOutlet weak var cityInput: UITextField!
    @IBOutlet weak var stateInput: UITextField!
    
    @IBAction func submitButton(sender: AnyObject) {
        
        //We gotta put the URL together first
        
        //get city name and remove beginning and ending whitespaces
        var cityName = cityInput.text.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        cityName = cityName.stringByReplacingOccurrencesOfString(" ", withString: "+", options: NSStringCompareOptions.LiteralSearch, range: nil)
        //get state code and remove beginning and ending whitespaces
        var stateCode = stateInput.text.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())

        //Insert city name into URL
        var urlWithCity = String()
        if !cityName.isEmpty {
            //let newString = aString.stringByReplacingOccurrencesOfString(" ", withString: "+", options: NSStringCompareOptions.LiteralSearch, range: nil)
            urlWithCity = self.WeatherUrl.stringByReplacingOccurrencesOfString("[CITY]", withString: cityName, options: NSStringCompareOptions.LiteralSearch, range: nil)
            
            self.WeatherUrl = urlWithCity
        }
        
        //Insert state code into URL
        var urlWithCityAndState = String()
        if !stateCode.isEmpty {
            urlWithCityAndState = self.WeatherUrl.stringByReplacingOccurrencesOfString("[STATE]", withString: stateCode, options: NSStringCompareOptions.LiteralSearch, range: nil)
            
            self.WeatherUrl = urlWithCityAndState
        }
        
        println(self.WeatherUrl)
        
        //Now lets get some weather
        let url = NSURL(string: self.WeatherUrl)
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {
            (data, response, error) in
            
            if error == nil {
                var info = data //NSString(data: data, encoding: NSUTF8StringEncoding)
                println(info!)
                
                
                dispatch_async(dispatch_get_main_queue()) {
                    println("async?")
                    //self.webView.loadHTMLString(info!, baseURL: nil)
                    WeatherResults = info!
                }
            }
            else {
                println(error)
            }
        }
        
        task.resume()
        /*
        var temp = String()
        temp = "I've been passed around"
        WeatherResults = temp
        */
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.cityInput.text = "Newport News"
        self.stateInput.text = "va"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        if cityInput.text.isEmpty || cityInput.text.isEmpty {
            return false
        }
        else {
            return true
        }
    }

}

