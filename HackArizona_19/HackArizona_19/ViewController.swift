//
//  ViewController.swift
//  HackArizona_19
//
//  Created by Mohit on 19/01/19.
//  Copyright © 2019 Mohit D. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation     // to get current user location

class ViewController: UIViewController, CLLocationManagerDelegate {

    var jsonResult:NSDictionary?
    var apiresult:NSDictionary?
    var locationManager = CLLocationManager()
    var placity:String = "Tempe"
    var passingCoordinates: CLLocationCoordinate2D?
    var choice:Int = 0
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.locationManager.requestAlwaysAuthorization()
        if(CLLocationManager.locationServicesEnabled())
        {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        self.loadcivicdata(city: placity) // the JSON will be readied here
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let currloc:CLLocationCoordinate2D = manager.location!.coordinate
        self.passingCoordinates = currloc
        print("PASSING: ", self.passingCoordinates)
        apicall(cdns: currloc)
    }
    
    @IBAction func Contac(_ sender: UIButton) {
        choice = 0
        }
    
    @IBAction func Start(_ sender: UIButton)
    {
        choice = 1
    }
    func loadcivicdata(city: String = "Tempe")// -> String
    {
        var c = city
        if(c == "")
        {
            c = "Tempe"
        }
        c = c.replacingOccurrences(of: ",", with: "")
        c = c.replacingOccurrences(of: " ", with: "+")

        
        let defaultSession = URLSession(configuration: URLSessionConfiguration.default)
        var dataTask: URLSessionDataTask?
        var url : String = "https://www.googleapis.com/civicinfo/v2/representatives?address=\(c)&levels=country&roles=legislatorUpperBody&roles=legislatorLowerBody&key=AIzaSyB0HjKV1AZSOL8plciTh7e5bYYsrLzAZd0"
        var apiURL = URL(string: url)
        print("line 30", apiURL!) // Debugging
        dataTask = defaultSession.dataTask(with: apiURL!) {
            data, response, error in
            
            if let error = error {
                print(error.localizedDescription)
            } else if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    if let responseData = data {
                        if let json = try? JSONSerialization.jsonObject(with: responseData, options: .allowFragments) as? NSDictionary {
                            print(json!)
                            self.jsonResult = json
                        }
                    }
                }
            }
        }
        
        dataTask?.resume()
        
    } // end of loadcivicdata()             --- ALL OK _/
    
    
    
    func apicall(cdns: CLLocationCoordinate2D)
    {
        var urlAsString = "https://maps.googleapis.com/maps/api/geocode/json?latlng=\(cdns.latitude),\(cdns.longitude)&key=AIzaSyDXdSCo1wX5HbKg79T0_3ClF1q7aF9FYx0"

        print("\n\n \(urlAsString)")
        let url = URL(string: urlAsString)!
        let urlSession = URLSession.shared
        
        let jsonQuery = urlSession.dataTask(with: url, completionHandler: { data, response, error -> Void in
            if (error != nil) {
                print(error!.localizedDescription)
            }
            var err: NSError?
            
             self.apiresult = (try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers)) as! NSDictionary
            if (err != nil) {
                print("JSON Error \(err!.localizedDescription)")
            }
            
        })
        jsonQuery.resume()
    }
    
   
    
    // Delete everything below except for prepare
    
    
    
    
    


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let val = apiresult {
            var res = apiresult!["results"] as! NSArray
            var first = res[0] as! NSDictionary
            self.placity = first["formatted_address"] as! String
            self.loadcivicdata(city: placity)
        }
        
        if(choice == 0){
        let des = segue.destination as! RepsViewController
        des.jsonFromVC = jsonResult
        }
        if(choice == 1){
        let des2 = segue.destination as! OptionsViewController
        des2.usercoor = self.passingCoordinates
        }
    }
}

