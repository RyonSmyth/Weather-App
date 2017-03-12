//
//  ViewController.swift
//  Weather
//
//  Created by Ryan Smith on 3/8/17.
//  Copyright © 2017 Ryan Smith. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var currentWeather: UILabel!
    @IBOutlet weak var currentTemperature: UILabel!
    
    @IBAction func submitCity(_ sender: AnyObject) {
        
        let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=\(cityTextField.text!.replacingOccurrences(of: " ", with: "-"))&appid=dfdad3c0762a4417184b33f528c90b85")!
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if error != nil {
                print(error)
            } else {
                let parsedResult: [String: AnyObject]
                do {
                    parsedResult = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String: AnyObject]
                    
                    let weather = (parsedResult["weather"] as! NSArray)[0] as! NSDictionary
                    let description = weather["description"] as! String
                    print(description)
                    
                    
                    let main = parsedResult["main"] as! [String: AnyObject]
                    let temp = main["temp"] as! Float
                    print(temp)
                    
                    DispatchQueue.main.sync {
                        
                        self.currentWeather.text = description.capitalized
                        self.currentTemperature.text = "\(Int(temp * (9/5) - 459.67))°F"
                        
                        self.currentWeather.isHidden = false
                        self.currentTemperature.isHidden = false
                    }
                    
                    
                    
                } catch {
                    print("Could not parse the data as JSON: '\(data)'")
                    return
                }            }
        }
        task.resume()
        
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentWeather.isHidden = true
        currentTemperature.isHidden = true
        
}

        

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

