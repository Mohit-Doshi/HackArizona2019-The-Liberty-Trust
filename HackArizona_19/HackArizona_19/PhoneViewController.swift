//
//  PhoneViewController.swift
//  HackArizona_19
//
//  Created by Mohit on 19/01/19.
//  Copyright © 2019 Mohit D. All rights reserved.
//

import UIKit

class PhoneViewController: UIViewController {
    
    var sentphone:String?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print(Int(sentphone!))
        self.callSellerPressed()
    }
    
    func callSellerPressed()
    {
        //(This is calls a specific number)UIApplication.sharedApplication().openURL(NSURL(string: "tel://######")!)
        
        if let url = NSURL(string: "tel://\(Int(sentphone!))"), UIApplication.shared.canOpenURL(url as URL) {
            UIApplication.shared.openURL(url as URL)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
