//
//  Tracker.swift
//  TrackerSMS
//
//  Created by Dennis Sørensen on 27/10/2019.
//  Copyright © 2019 Dennis Sørensen. All rights reserved.
//

import Foundation

class Tracker : Codable {
    var phoneNumber : String
    var messageCommand : String
    var messageCode : String
    
    //MARK: STATIC
    static let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first! //Sti til der hvor man skal gemme dataene
    static let archiveUrl = documentsDirectory.appendingPathComponent("Tracker").appendingPathExtension("plist") //Filen som dataene gemmes i
    
    init(phoneNumber: String, messageCommand: String, messageCode: String) {
        self.phoneNumber = phoneNumber
        self.messageCommand = messageCommand
        self.messageCode = messageCode
    }
    
    //Funktion der tager tracker listen fra app delegate, og gemmer den til disk
    static func saveTrackersToFile() {
        let myEncoder = PropertyListEncoder()
        let encodedMachines = try? myEncoder.encode(AppDelegate.trackers) //Prøver at encode maskinerne
        try? encodedMachines?.write(to: archiveUrl, options: .noFileProtection) //Prover at skrive dataene
    }
    
    //Funktion der henter listen af gemte maskiner fra disk
    static func loadTrackersFromFile() -> [Tracker]? {
        let myDecoder = PropertyListDecoder()
        
        if let recivedMachineData = try? Data(contentsOf: archiveUrl) {
            let decodedMachines = try? myDecoder.decode(Array<Tracker>.self, from: recivedMachineData)
            return decodedMachines
        }
        return nil
    }
}
