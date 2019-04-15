//
//  SecurityViewController.swift
//  HackArizona_19
//
//  Created by Mohit on 20/01/19.
//  Copyright © 2019 Mohit D. All rights reserved.
//

import UIKit

class SecurityViewController: UIViewController
{
    
    var sum:Int = 0
    
    @IBAction func B2(_ sender: UIButton) {
        sum = 1
    }
    
    @IBAction func B3(_ sender: UIButton) {
        sum = 2
        performSegue(withIdentifier: "USTV", sender: self)
    }
    @IBOutlet weak var B1: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let alertController = UIAlertController(title: "Enter the passcode", message: "", preferredStyle: .alert)
       
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
        
        } //end of OKAction
        
        alertController.addAction(OKAction)
        //  alertController.addAction(cancelAction)
        

        
        self.present(alertController, animated: true, completion: nil)
        

    }
    
    @IBAction func unwindToVC1(segue:UIStoryboardSegue) { }

    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
