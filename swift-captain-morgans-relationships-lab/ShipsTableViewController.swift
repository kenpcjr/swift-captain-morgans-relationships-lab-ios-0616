//
//  ShipsTableViewController.swift
//  swift-captain-morgans-relationships-lab
//
//  Created by Kenneth Cooke on 7/24/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ShipsTableViewController: UITableViewController {
    
    let dataStore = DataStore.sharedDataStore
    
    var shipsToDisplay = Set<Ship>()
    var shipsAsArray = [Ship]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for ship in shipsToDisplay {
            
            shipsAsArray.append(ship)
        }
        
        let alphaSort = NSSortDescriptor.init(key: "name", ascending: true)
        let alphashipsAsArray = (shipsAsArray as NSArray).sortedArrayUsingDescriptors([alphaSort])
        shipsAsArray = alphashipsAsArray as! [Ship]
        print("ShipsAsArray: \(shipsAsArray.count)")
    }
    
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return shipsAsArray.count
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("basicCell", forIndexPath: indexPath)
        
        cell.textLabel?.text = shipsAsArray[indexPath.row].name
        
        return cell
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "shipDetailSegue" {
            
            let destVC = segue.destinationViewController as! ShipDetailViewController
            
            if let tappedShip = tableView.indexPathForSelectedRow?.row {
                
                
                
                destVC.passedShip = shipsAsArray[tappedShip] as Ship?
                
            }
            
        }
        
        
        
    }
}


