//
//  ShoppingList.swift
//  Muumi
//
//  Created by Jonathan Budiman on 2024/02/13.
//

import Foundation
import RealmSwift

class ShoppingList: Object, Identifiable { // 継承
    @Persisted(primaryKey: true) var id: ObjectId // Allow the property to be persisted into the RealmDB storage
    @Persisted var title: String
    @Persisted var address: String
    
    override class func primaryKey() -> String? {
         "id"
    }
}
