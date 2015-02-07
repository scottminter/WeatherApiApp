//
//  ViewController.swift
//  Weather API App
//
//  Created by Scott Minter on 2/2/15.
//  Copyright (c) 2015 Scott Minter Designs. All rights reserved.
//

import UIKit

var WeatherResults = NSData()
var WeatherErrors = NSError()

func getWeatherData(WeatherUrl: String)->NSURLSessionDataTask {
    let url = NSURL(string: WeatherUrl)
println(url)
    let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {
        (data, response, error) in

        if error == nil {
            var info = data
            
            dispatch_async(dispatch_get_main_queue()) {
                WeatherResults = info!
                println("We just got data back")
            }
        }
        else {
            WeatherErrors = error
            println("error: \(error)")
        }
    }
    
    return task
}

class ViewController: UIViewController {
    
    var WeatherUrl: String = "http://api.openweathermap.org/data/2.5/weather?q=[CITY],[STATE],US&units=imperial"
    var ApiError: Bool = false
    var cityName = String()
    var stateCode = String()

    @IBOutlet weak var cityInput: UITextField!
    @IBOutlet weak var stateInput: UITextField!
    @IBOutlet weak var submitButtonOutlet: UIButton!
    @IBOutlet var ViewCtrlr: UIView!
    
    @IBAction func submitButton(sender: AnyObject) {
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
        
        /**
         * Now lets get some weather
         */
        var task = getWeatherData(self.WeatherUrl)
        task.resume()
        
        //Segue Now
        performSegueWithIdentifier("segue1", sender: self)
    }
    
    //Passing data to SecondViewController
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "segue1" {
            var svc = segue.destinationViewController as SecondViewController
            
            var locationObj = Dictionary<String, String>()
            locationObj["url"] = self.WeatherUrl as String
            locationObj["cityName"] = self.cityName
            locationObj["stateCode"] = self.stateCode
            
            svc.toPass = locationObj
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        //Seeing some occasional strange behavior where the previous city is put
        //in the new search.  This is just outputting the current cityName and 
        //stateCode when the veiw comes back into...err...view. 
        //Seems to be an api issue.
        
        println("City Name: \(self.cityName)")
        println("State Code: \(self.stateCode)")
        //self.cityInput.text = "Virginia Beach"
        //self.stateInput.text = "VA"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
println("\n\n******** NEW RUN *********")
        //self.cityInput.text = "Newport Bad News"
        //self.stateInput.text = "VA"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

