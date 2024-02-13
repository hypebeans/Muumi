//
//  ShoppingItem.swift
//  Muumi
//
//  Created by Jonathan Budiman on 2024/02/13.
//

import Foundation
import RealmSwift

class ShoppingItem: Object, Identifiable {
    @Persisted(primaryKey: true)  var id: ObjectId
    @Persisted var title: String
    @Persisted var quantity: Int
    @Persisted var price: Int
    @Persisted var category: String
    
    override class func primaryKey() -> String? {
        return "id"
    }
}
