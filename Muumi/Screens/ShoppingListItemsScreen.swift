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
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.dismiss) var dismiss
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
            if shoppingList.items.isEmpty {
                Spacer()
                Image("No Items Found")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .scaleEffect(1.25)
                    .padding()
                Spacer()
            } else {
                CategoryFilterView(selectedCategory: $selectedCategory)
                    .padding()
                List {
                    ForEach(items) { item in
                        NavigationLink {
                            AddShoppingListItemScreen(shoppingList: shoppingList, itemToEdit: item)
                            
                        } label: {
                            ShoppingItemCell(item: item, selected: selectedItemIds.contains(item.id)) { selected in
                                if selected {
                                    selectedItemIds.append(item.id)
                                    if let indexToDelete = shoppingList.items.firstIndex(where: { $0.id == item.id }) {
                                        // アイテム削除
                                        $shoppingList.items.remove(at: indexToDelete)
                                    }
                                }
                            }
                        }
                    }.onDelete(perform: $shoppingList.items.remove)
                }
                .navigationBarBackButtonHidden(true)
                .navigationBarTitle("", displayMode: .inline)
                .navigationBarItems(leading:
                   Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundStyle(Color("PrimaryColor"))
                })
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text(shoppingList.title)
                            .font(.custom("Futura", size: 24))
                    }
                    //                        ToolbarItem(placement: .navigationBarTrailing) {
                    //                            Button {
                    //                                isPresented = true
                    //                            } label: {
                    //                                Image(systemName: "plus")
                    //                                    .foregroundStyle(Color("PrimaryColor"))
                    //                            }
                    //                        }
                }.sheet(isPresented: $isPresented) {
                    AddShoppingListItemScreen(shoppingList: shoppingList)
                }
            }
        }
        .padding()
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading:
                                Button(action: {
            dismiss()
        }) {
            HStack {
                Image(systemName: "chevron.left")
            }
            .foregroundColor(Color("PrimaryColor"))
        })
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    isPresented = true
                } label: {
                    Image(systemName: "plus")
                        .foregroundStyle(Color("PrimaryColor"))
                }
            }
        }
        .sheet(isPresented: $isPresented) {
            AddShoppingListItemScreen(shoppingList: shoppingList)
        }
    }
}

#Preview {
    NavigationView {
        ShoppingListItemsScreen(shoppingList: ShoppingList())
    }
}
