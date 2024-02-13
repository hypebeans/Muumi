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
    @Environment(\.dismiss) var dismiss
    
    @State private var title: String = ""
    @State private var quantity: String = ""
    @State private var selectedCategory = ""
    
    let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    let data = ["Produce", "Fruit", "Meat", "Condiments", "Beverages", "Snacks", "Dairy"]
    
    var body: some View {
        NavigationView {
            VStack {
                LazyVGrid(columns: columns) {
                    ForEach(data, id: \.self) { item in
                            Text(item)
                            .padding()
                            .frame(width: 130)
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
                    // アイテム保存
                    let shoppingItem = ShoppingItem()
                    shoppingItem.title = title
                    shoppingitem.quantity = Int(quantity) ?? 1
                    shoppingItem.category = selectedCategory
                    $shoppingList.items.append(shoppingItem)
                    
                    dismiss()
                    
                } label: {
                    Text("Save")
                        .frame(maxWidth: .infinity, maxHeight: 40)
                }.buttonStyle(.bordered)
                
            }.padding()
        }
    }
}

#Preview {
    AddShoppingListItemScreen(shoppingList: ShoppingList())
}
