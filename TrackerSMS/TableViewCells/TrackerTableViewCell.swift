//
//  TrackerTableViewCell.swift
//  TrackerSMS
//
//  Created by Dennis Sørensen on 28/10/2019.
//  Copyright © 2019 Dennis Sørensen. All rights reserved.
//

import UIKit

class TrackerTableViewCell: UITableViewCell {

    var tracker : Tracker?
    var selectionCallback: ((String) -> Void)?
    
    @IBOutlet weak var trackerLabel: UILabel!
    
    @IBAction func commandButtonPressed(_ sender: UIButton) {
        var command : String = ""
        switch sender.titleLabel?.text {
        case "Arm":
            command = "arm"
        case "Disarm":
             command = "disarm"
        case "Check":
            command = "check"
        case "Find":
            command = "smslink"
        default:
            return
        }
        self.selectionCallback?(command)
    }
    
    func sendSmsToTracker() {
        
    }
    
    func setupCell(myTracker: Tracker) {
        tracker = myTracker
        trackerLabel.text = tracker!.name
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
    }

}
