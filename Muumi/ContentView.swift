//
//  ContentView.swift
//  Muumi
//
//  Created by Jonathan Budiman on 2024/02/13.
//

import SwiftUI
import RealmSwift

struct ContentView: View {
    
    @ObservedResults(ShoppingList.self) var shoppingLists
    @State private var isPresented: Bool = false
    //    @State private var isLaunched: Bool = true
    
    var body: some View {
        
        NavigationView {
            VStack {
                if shoppingLists.isEmpty {
                    Text("No shopping lists!")
                }
                List {
                    ForEach(shoppingLists, id: \.id) { shoppingList in
                        NavigationLink {
                            ShoppingListItemsScreen(shoppingList: shoppingList)
                        } label: {
                            VStack(alignment: .leading) {
                                Text(shoppingList.title)
                                Text(shoppingList.address)
                                    .opacity(0.4)
                            }
                        }
                    }.onDelete(perform: $shoppingLists.remove)
                }
            }
            .sheet(isPresented: $isPresented, content: {
                AddShoppingListScreen()
            })
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Image("MuumiText")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isPresented = true
                    } label: {
                        Image(systemName: "plus")
                            .foregroundColor(Color("PrimaryColor"))
                    }
                }
            }
        }
        
        
        
    }
}

#Preview {
    ContentView()
}
