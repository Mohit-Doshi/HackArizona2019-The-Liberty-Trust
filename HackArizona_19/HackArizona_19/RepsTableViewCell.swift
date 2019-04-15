//
//  RepsTableViewCell.swift
//  HackArizona_19
//
//  Created by Mohit on 19/01/19.
//  Copyright © 2019 Mohit D. All rights reserved.
//

import UIKit

class RepsTableViewCell: UITableViewCell {

    @IBOutlet weak var Name_Label: UILabel!
    @IBOutlet weak var Number_Label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
