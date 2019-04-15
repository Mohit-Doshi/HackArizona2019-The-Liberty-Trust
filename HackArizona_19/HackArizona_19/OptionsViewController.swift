//
//  OptionsViewController.swift
//  HackArizona_19
//
//  Created by Mohit on 20/01/19.
//  Copyright © 2019 Mohit D. All rights reserved.
//

import UIKit
import MapKit
import SafariServices

class OptionsViewController: UIViewController, CLLocationManagerDelegate {
    
    var usercoor:CLLocationCoordinate2D?     // sent from view controller
    var choice:Int = -1

    override func viewDidLoad()
    {
            super.viewDidLoad()
            // Do any additional setup after loading the view.
    }
    @IBAction func Volunteering(_ sender: UIButton) {
        choice = 0
    }
    @IBAction func CashCrypto(_ sender: Any) {
        let svc = SFSafariViewController(url: URL(string: "https://docs.google.com/forms/d/e/1FAIpQLScy88cPh66lj5l6v5eOzIEJiXbQlzx56_-MCErLcr6VfTKZZw/viewform?usp=sf_link")!)
            self.present(svc, animated: true, completion: nil)
        
        choice = 1
    }
    
    @IBAction func Food_Banks(_ sender: UIButton) {
        choice = 2
    }
    @IBAction func Donate(_ sender: UIButton)
    {
        choice = 3
    }
    @IBAction func AnotherCity(_ sender: UITextField) {
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if(choice == 0){
            let des = segue.destination as! MapsViewController
            des.coords = usercoor
            des.keyw = "Volunteer"
        }
        if(choice == 1){
            let des = segue.destination as! SecurityViewController
        }
        if(choice == 2){
            let des = segue.destination as! MapsViewController
            des.coords = usercoor
            des.keyw = "Food Bank"
        }
        if(choice == 3){
            let des = segue.destination as! MapsViewController
            des.coords = usercoor
            des.keyw = "Food Bank"
        }
    }
    
    
    @IBAction func fromDetailedViewController(segue: UIStoryboardSegue) // unwind segue method
    {
        
        let alertController = UIAlertController(title: "Success!!", message: "", preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
            
        } //end of OKAction
        
        alertController.addAction(OKAction)
        //  alertController.addAction(cancelAction)
        
        
        
        self.present(alertController, animated: true, completion: nil)
        
        /*   if let sourceViewController = segue.source as? DetailedViewController
         {
         
         }*/
        
    }
    

}
