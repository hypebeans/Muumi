//
//  AddShoppingListItemScreen.swift
//  Muumi
//
//  Created by Jonathan Budiman on 2024/02/13.
//

import SwiftUI
import RealmSwift

struct AddShoppingListItemScreen: View {
    
    @ObservedRealmObject var shoppingList: ShoppingList
    var itemToEdit: ShoppingItem?
    
    @Environment(\.dismiss) var dismiss
    
    @State private var title: String = ""
    @State private var quantity: String = ""
    @State private var selectedCategory = ""
    
    let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    let data = ["Produce", "Fruit", "Meat", "Condiments", "Beverages", "Snacks", "Dairy"]
    
    init(shoppingList: ShoppingList, itemToEdit: ShoppingItem? = nil) {
        self.shoppingList = shoppingList
        self.itemToEdit = itemToEdit
        
        if let itemToEdit = itemToEdit { // Changing the state property
            _title = State(initialValue: itemToEdit.title)
            _quantity = State(initialValue: String(itemToEdit.quantity))
            _selectedCategory = State(initialValue: itemToEdit.category)
        }
    }
    
    private var isEditing: Bool {
        itemToEdit == nil ? false : true
    }
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            if !isEditing {
                Text("Add Item")
                    .font(.largeTitle)
            }
            
            LazyVGrid(columns: columns) {
                ForEach(data, id: \.self) { item in
                    Text(item)
                        .padding()
                        .frame(width: 110)
                        .background(selectedCategory == item ? .orange : .green)
                        .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
                        .foregroundColor(.white)
                        .onTapGesture {
                            selectedCategory = item
                        }
                }
            }
            Spacer().frame(height: 60)
            TextField("Title", text: $title)
                .textFieldStyle(.roundedBorder)
            TextField("Quantity", text: $quantity)
                .textFieldStyle(.roundedBorder)
            
            Button {
                // アイテム保存または更新
                
                if let _ = itemToEdit { // If itemToEdit has some sort of value
                    // 更新
                    updateShoppingItem()
                } else {
                    // 保存
                    saveShoppingItem()
                }
                
                dismiss()
                
            } label: {
                Text(isEditing ? "Update" : "Save")
                    .frame(maxWidth: .infinity, maxHeight: 40)
            }.buttonStyle(.bordered)
                .padding(.top, 20)
            Spacer()
                .navigationTitle(isEditing ? "Update Item" : "Add Item")
        }.padding()
        
    }
    
    private func saveShoppingItem() {
        let shoppingItem = ShoppingItem()
        shoppingItem.title = title
        shoppingItem.quantity = Int(quantity) ?? 1
        shoppingItem.category = selectedCategory
        $shoppingList.items.append(shoppingItem)
    }
    
    private func updateShoppingItem() {
        if let itemToEdit = itemToEdit {
            do {
                let realm = try Realm()
                guard let objectToUpdate = realm.object(ofType: ShoppingItem.self, forPrimaryKey: itemToEdit.id) else { return }
                try realm.write { // Perform the update
                    objectToUpdate.title = title
                    objectToUpdate.category = selectedCategory
                    objectToUpdate.quantity = Int(quantity) ?? 1
                }
            } catch {
                print(error)
            }
        }
    }
}

#Preview {
    AddShoppingListItemScreen(shoppingList: ShoppingList())
}
