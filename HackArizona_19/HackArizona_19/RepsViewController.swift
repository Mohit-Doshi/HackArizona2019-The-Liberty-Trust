//
//  RepsViewController.swift
//  HackArizona_19
//
//  Created by Mohit on 19/01/19.
//  Copyright © 2019 Mohit D. All rights reserved.
//

import UIKit
import MapKit

class RepsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    var jsonFromVC:NSDictionary?
    var reps:NSArray?
    var rname:[String] = []
    var rnum:[String] = []
    
    @IBOutlet weak var RepsTable: UITableView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        print(jsonFromVC!)
        reps = jsonFromVC!["officials"] as? NSArray
        Heading.text = "Contacts"
        // Do any additional setup after loading the view.
        for i in 0..<reps!.count
        {
            var btemp:NSDictionary = reps![i] as! NSDictionary    // going through each of the elements in bs, parsing each of them as a Dictionary object
            rname.append(btemp["name"] as! String)
            var temp:NSArray = btemp["phones"] as! NSArray
            rnum.append(temp[0] as! String)
            // appending only the values from the name-keys for each of the dictionary objects into an array
        }
    }
    
    @IBOutlet weak var Heading: UILabel!
    
    // Delegate Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reps!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RepsTableViewCell
        cell.layer.borderWidth = 1.0
        cell.Name_Label.text = rname[indexPath.row]
        cell.Number_Label.text = "☎️\(rnum[indexPath.row])"
       // cell.backgroundColor = UIColor.blue
       // cell.BuildingImage.image = UIImage(named: "innovation.jpg")
        return cell
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        
        // Pass the selected object to the new view controller.
        let selectedIndex: IndexPath = self.RepsTable.indexPath(for: sender as! UITableViewCell)!
        var temp:NSDictionary = reps![selectedIndex.row] as! NSDictionary // accessing the particular dictionary
        let des = segue.destination as! PhoneViewController
        var t:NSArray = temp["phones"] as! NSArray
        des.sentphone = t[0] as! String
        
    }
    

    
    
}
