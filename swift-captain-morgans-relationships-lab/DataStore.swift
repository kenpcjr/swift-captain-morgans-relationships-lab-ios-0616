//
//  DataStore.swift
//  swift-captain-morgans-relationships-lab
//
//  Created by Kenneth Cooke on 7/24/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation
import CoreData

class DataStore {
    
    static let sharedDataStore = DataStore()
    
    
    var allStoredPirates: [Pirates] = []
    
    
    func fetchData() {
        
        let fetchPirates = NSFetchRequest.init(entityName: "Pirates")
        let alphaBetSort = NSSortDescriptor.init(key: "name", ascending: true)
        fetchPirates.sortDescriptors = [alphaBetSort]
        
        do {
            
            try allStoredPirates = self.managedObjectContext.executeFetchRequest(fetchPirates) as! [Pirates]
            
        } catch {
            
            print("error with fetchPirates")
            
        }
        
        if allStoredPirates.count == 0 {
            generateTestData()
           
        }
        
    }
    
    
    func generateTestData() {
        
        var pirateBob = NSEntityDescription.insertNewObjectForEntityForName("Pirates", inManagedObjectContext: self.managedObjectContext) as! Pirates
        pirateBob.name = "Bob the Bumbling"
        
        var pirateLisa = NSEntityDescription.insertNewObjectForEntityForName("Pirates", inManagedObjectContext: self.managedObjectContext) as! Pirates
        pirateLisa.name = "Lisa the Vile"
        
        var pirateKen = NSEntityDescription.insertNewObjectForEntityForName("Pirates", inManagedObjectContext: self.managedObjectContext) as! Pirates
        pirateKen.name = "Ken the Swift, Just, and Handsome"
        
        var shipBob = NSEntityDescription.insertNewObjectForEntityForName("Ship", inManagedObjectContext: self.managedObjectContext) as! Ship
        shipBob.name = "The BSS Most Certainly"
        shipBob.pirate = pirateBob
        
        var shipLisa = NSEntityDescription.insertNewObjectForEntityForName("Ship", inManagedObjectContext: self.managedObjectContext) as! Ship
        shipLisa.name = "The BSS First I'm Hearing About It"
        shipLisa.pirate = pirateLisa
        
        var shipKen = NSEntityDescription.insertNewObjectForEntityForName("Ship", inManagedObjectContext: self.managedObjectContext) as! Ship
        shipKen.name = "The HAM Shane"
        shipKen.pirate = pirateKen
        
        var shipKen2 = NSEntityDescription.insertNewObjectForEntityForName("Ship", inManagedObjectContext: self.managedObjectContext) as! Ship
        shipKen2.name = "The HAM Anna"
        shipKen2.pirate = pirateKen
        
        let engineTypeShane = NSEntityDescription.insertNewObjectForEntityForName("Engine", inManagedObjectContext: self.managedObjectContext) as! Engine
        engineTypeShane.propulsion = "Sail"
        engineTypeShane.ship = shipKen
        
        let engineTypeAnna = NSEntityDescription.insertNewObjectForEntityForName("Engine", inManagedObjectContext: self.managedObjectContext) as! Engine
        engineTypeAnna.propulsion = "Sail"
        engineTypeAnna.ship = shipKen2
        
        let engineTypeCertainly = NSEntityDescription.insertNewObjectForEntityForName("Engine", inManagedObjectContext: self.managedObjectContext) as! Engine
        engineTypeCertainly.propulsion = "Gas"
        engineTypeCertainly.ship = shipBob
        
        let engineTypeHearing = NSEntityDescription.insertNewObjectForEntityForName("Engine", inManagedObjectContext: self.managedObjectContext) as! Engine
        engineTypeHearing.propulsion = "Electric"
        engineTypeHearing.ship = shipLisa
        
        
        saveContext()
        fetchData()
        
        
    }

    
    
    var managedObjectContext: NSManagedObjectContext
    init() {
        // This resource is the same name as your xcdatamodeld contained in your project.
        guard let modelURL = NSBundle.mainBundle().URLForResource("swift_captain_morgans_relationships_lab", withExtension:"momd") else {
            fatalError("Error loading model from bundle")
        }
        // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
        guard let mom = NSManagedObjectModel(contentsOfURL: modelURL) else {
            fatalError("Error initializing mom from: \(modelURL)")
        }
        let psc = NSPersistentStoreCoordinator(managedObjectModel: mom)
        managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = psc
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)) {
            let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
            let docURL = urls[urls.endIndex-1]
            /* The directory the application uses to store the Core Data store file.
             This code uses a file named "DataModel.sqlite" in the application's documents directory.
             */
            let storeURL = docURL.URLByAppendingPathComponent("swift_captain_morgans_relationships_lab.sqlite")
            do {
                try psc.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: storeURL, options: nil)
            } catch {
                fatalError("Error migrating store: \(error)")
            }
        }
    }
    
    func saveContext () {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }


}
