//
//  ShoppingListItemsScreen.swift
//  Muumi
//
//  Created by Jonathan Budiman on 2024/02/13.
//

import SwiftUI
import RealmSwift

struct ShoppingListItemsScreen: View {
    
    @ObservedRealmObject var shoppingList: ShoppingList
    @State private var isPresented: Bool = false
    @State private var selectedItemIds: [ObjectId] = []
    @State private var selectedCategory: String = "All"
    
    var body: some View {
        VStack {
            Text("Items")
            
                .navigationTitle("HEB")
        }.toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    isPresented = true
                } label: {
                    Image(systemName: "plus")
                }
            }
        }.sheet(isPresented: $isPresented) {
            AddShoppingListItemScreen(shoppingList: shoppingList)
        }
    }
}

#Preview {
    NavigationView {
        ShoppingListItemsScreen(shoppingList: ShoppingList())
    }
}
