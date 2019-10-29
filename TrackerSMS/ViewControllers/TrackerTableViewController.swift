//
//  TrackerTableViewController.swift
//  TrackerSMS
//
//  Created by Dennis Sørensen on 28/10/2019.
//  Copyright © 2019 Dennis Sørensen. All rights reserved.
//

import UIKit
import MessageUI


class TrackerTableViewController: UITableViewController, MFMessageComposeViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        Tracker.loadTrackersFromFile()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return AppDelegate.trackers.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! TrackerTableViewCell

        // Configure the cell...

        let myTracker = AppDelegate.trackers[indexPath.row]
        
        cell.setupCell(myTracker: myTracker)
        cell.selectionCallback = { (data: String) -> () in
            self.showSmsView(withTracker: myTracker, command: data)
        }
        
        return cell
    }
    
    //Fjern send sms ViewController
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //Funktion der samler beskeden og viser den til brugeren
    func showSmsView(withTracker tracker: Tracker, command: String) {
        if MFMessageComposeViewController.canSendText() {
            let controller = MFMessageComposeViewController()
            controller.body = command + tracker.messageCode //Indhold af besked
            controller.recipients = [tracker.phoneNumber]
            controller.messageComposeDelegate = self
            self.present(controller, animated: true, completion: nil)
        }
        else {
            print("Can't send sms")
        }
    }

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            AppDelegate.trackers.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            Tracker.saveTrackersToFile()
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func unwindToTrackerTableViewController(_ unwindSegue: UIStoryboardSegue) {
        let sourceViewController = unwindSegue.source
        // Use data from the view controller which initiated the unwind segue
        guard unwindSegue.identifier == "saveUnwind" else {
            return
        }
        
        guard let sourceVC = sourceViewController as? AddTrackerTableViewController else {return}
        
        //Tilføjer og gemmer den nyoprettet tracker
        let newIndexPath = IndexPath(row: AppDelegate.trackers.count, section: 0)
        AppDelegate.trackers.append(sourceVC.tracker)
        tableView.insertRows(at: [newIndexPath], with: .automatic)
        
        Tracker.saveTrackersToFile()
    }
}
