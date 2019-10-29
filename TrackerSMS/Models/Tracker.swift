//
//  Tracker.swift
//  TrackerSMS
//
//  Created by Dennis Sørensen on 27/10/2019.
//  Copyright © 2019 Dennis Sørensen. All rights reserved.
//

import Foundation

class Tracker : Codable {
    var name : String
    var phoneNumber : String
    var messageCode : String
    
    //MARK: STATIC
    static let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first! //Sti til der hvor man skal gemme dataene
    static let archiveUrl = documentsDirectory.appendingPathComponent("Tracker").appendingPathExtension("plist") //Filen som dataene gemmes i
    
    init(name: String, phoneNumber: String, messageCode: String) {
        self.name = name
        self.phoneNumber = phoneNumber
        self.messageCode = messageCode
    }
    
    init() {
        self.name = ""
        self.phoneNumber = ""
        self.messageCode = ""
    }
    
    //Funktion der tager tracker listen fra app delegate, og gemmer den til disk
    static func saveTrackersToFile() {
        let myEncoder = PropertyListEncoder()
        let encodedTrackers = try? myEncoder.encode(AppDelegate.trackers) //Prøver at encode maskinerne
        try? encodedTrackers?.write(to: archiveUrl, options: .noFileProtection) //Prover at skrive dataene
    }
    
    //Funktion der henter listen af gemte maskiner fra disk
    static func loadTrackersFromFile() {
        let myDecoder = PropertyListDecoder()
        
        if let recivedTrackerData = try? Data(contentsOf: archiveUrl) {
            let decodedTrackers = try? myDecoder.decode(Array<Tracker>.self, from: recivedTrackerData)
            AppDelegate.trackers = decodedTrackers ?? []
        }
    }
}
