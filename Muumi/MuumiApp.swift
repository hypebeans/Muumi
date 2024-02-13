//
//  MuumiApp.swift
//  Muumi
//
//  Created by Jonathan Budiman on 2024/02/13.
//

import SwiftUI

@main
struct MuumiApp: App {
    
    let migrator = Migrator() // Running the migration
    
    var body: some Scene {
        WindowGroup {
            let _ = UserDefaults.standard.set(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable") // Constraint error handling
            let _ = print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.path) // Document directory path
            ContentView()
        }
    }
}
