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
    @State private var selectedItemIds: [ObjectId] = [] // To know which ID is being selected
    @State private var selectedCategory: String = "All"
    
    var items: [ShoppingItem] {
        if(selectedCategory == "All") {
            return Array(shoppingList.items)
        } else {
            return shoppingList.items.sorted(byKeyPath: "title")
                .filter { $0.category == selectedCategory }
        }
    }
    
    var body: some View {
        VStack {
            CategoryFilterView(selectedCategory: $selectedCategory)
                .padding()
            if shoppingList.items.isEmpty {
                Text("No items found")
            }
            List {
                ForEach(items) { item in
                    
                    NavigationLink {
                        AddShoppingListItemScreen(shoppingList: shoppingList, itemToEdit: item)
                    } label: {
                        ShoppingItemCell(item: item, selected: selectedItemIds.contains(item.id)) { selected in
                            if selected {
                                selectedItemIds.append(item.id)
                                if let indexToDelete = shoppingList.items.firstIndex(where: { $0.id == item.id }) {
                                    //アイテム削除
                                    $shoppingList.items.remove(at: indexToDelete)
                                }
                            }
                        }
                    }
                }.onDelete(perform: $shoppingList.items.remove)
            }
            .navigationTitle(shoppingList.title)
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
