//
//  ShipDetailViewController.swift
//  swift-captain-morgans-relationships-lab
//
//  Created by Kenneth Cooke on 7/24/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ShipDetailViewController: UIViewController {
    
    let dataStore = DataStore.sharedDataStore
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var pirateLabel: UILabel!
    @IBOutlet weak var engineLabel: UILabel!

    var passedShip: Ship?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = passedShip!.name
        pirateLabel.text = passedShip!.pirate?.name
        engineLabel.text = passedShip!.engine?.propulsion
        
        
        
    }
    

}
