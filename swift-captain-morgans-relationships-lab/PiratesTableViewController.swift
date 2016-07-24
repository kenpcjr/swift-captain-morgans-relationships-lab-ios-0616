//
//  PiratesTableViewController.swift
//  swift-captain-morgans-relationships-lab
//
//  Created by Kenneth Cooke on 7/24/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class PiratesTableViewController: UITableViewController {
    
    let dataStore = DataStore.sharedDataStore
    var piratesToDisplay = [Pirates]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(dataStore.allStoredPirates.count)
        
        dataStore.fetchData()
        piratesToDisplay = dataStore.allStoredPirates
        
        print(dataStore.allStoredPirates.count)
        
    }
    
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return piratesToDisplay.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
         let cell = self.tableView.dequeueReusableCellWithIdentifier("basicCell", forIndexPath: indexPath)
        
        cell.textLabel?.text = piratesToDisplay[indexPath.row].name
        
        return cell
    
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "shipsSegue" {
        
            let destVC = segue.destinationViewController as! ShipsTableViewController
            
            let tappedPirate = tableView.indexPathForSelectedRow?.row
            
            if let ships = piratesToDisplay[tappedPirate!].ships {
            
                destVC.shipsToDisplay = ships
                
            }
            
        }
    }
    
    

}
