//
//  Migrator.swift
//  Muumi
//
//  Created by Jonathan Budiman on 2024/02/13.
//

import Foundation
import RealmSwift

class Migrator {
    
    init() {
        updateSchema() // Update the schema
    }
    
    func updateSchema() {
        let config = Realm.Configuration(schemaVersion: 1) { migration, oldSchemaVersion in
            if oldSchemaVersion < 1 {
                // Add new fields (大事)
                migration.enumerateObjects(ofType: ShoppingList.className()) { _, newObject in
                    newObject!["items"] = List<ShoppingItem>()
                }
            }
            
            if oldSchemaVersion < 2 {
                migration.enumerateObjects(ofType: ShoppingItem.className()) { _, newObject in
                    newObject!["category"] = ""
                }
            }
            
            // Migration is required due to the following errors..
            
            
        }
        
        Realm.Configuration.defaultConfiguration = config
        let _ = try! Realm()
        
    }
}
