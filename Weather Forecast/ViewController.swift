//
//  ViewController.swift
//  Weather Forecast
//
//  Created by Gagandeep Nagpal on 19/06/16.
//  Copyright © 2016 Gagandeep Nagpal. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate {
    
    
    @IBOutlet var city: UITextField!
    
    
    @IBOutlet var result: UILabel!
    
    
    
    
    @IBAction func findWeather(sender: AnyObject) {
        
        
        self.result.text = ""
        
        
        var flag =  true
        
        let attemptedurl = NSURL(string: "http://www.weather-forecast.com/locations/"+city.text!.stringByReplacingOccurrencesOfString(" ", withString: "-")+"/forecasts/latest")
        
        
        if let url = attemptedurl {
        
            flag = false
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in
            
            
            
            if let urlContent = data {
                
                
                let webContent = NSString(data: urlContent, encoding: NSUTF8StringEncoding)

                
                let contentArray =  webContent!.componentsSeparatedByString("3 Day Weather Forecast Summary:</b><span class=\"read-more-small\"><span class=\"read-more-content\"> <span class=\"phrase\">")
                
                if contentArray.count > 1
                {
                    
                    let  contentArray = contentArray[1].componentsSeparatedByString("</span>")
                    
                    
                    if contentArray.count > 1
                    {
                        
                        
                        let weatherSummary = contentArray[0].stringByReplacingOccurrencesOfString("&deg;", withString: "º")
                        
                      
                        
                           dispatch_async(dispatch_get_main_queue(), {
                        
                            self.result.text = weatherSummary
                            
                         
                               })
                    
                            
                        
                    }
                    
                    
                    
                }
                
                
                
                
            }
            
            
            
            
        }
        
        task.resume()

        }
        
        if flag == true{
            
            self.result.text = "please try again"
            
        }
        
        
        
        
    }
    
    

    override func viewDidLoad() {
        
        self.city.delegate = self
        

    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        self.view.endEditing(true)
        
    }
    
    
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
        
    }



}

