//
//  Tracker.swift
//  TrackerSMS
//
//  Created by Dennis Sørensen on 27/10/2019.
//  Copyright © 2019 Dennis Sørensen. All rights reserved.
//

import Foundation

class Tracker {
    var phoneNumber : String
    var messageCommand : String
    var messageCode : String
    
    init(phoneNumber: String, messageCommand: String, messageCode: String) {
        self.phoneNumber = phoneNumber
        self.messageCommand = messageCommand
        self.messageCode = messageCode
    }
}
