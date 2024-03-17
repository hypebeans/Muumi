//
//  HomeView.swift
//  Muumi
//
//  Created by Jonathan Budiman on 2024/02/19.
//

import SwiftUI
import RealmSwift

struct HomeView: View {
    @ObservedResults(ShoppingList.self) var shoppingLists
    @State private var isPresented: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                if shoppingLists.isEmpty {
                    Spacer()
                    Image("No Shopping Lists")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .scaleEffect(1.25)
                        .padding()
                    Spacer()
                } else {
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
                            //TODO: カスタム
                            
                        }.onDelete(perform: $shoppingLists.remove)
                    }
                }
            }
            .sheet(isPresented: $isPresented, content: {
                AddShoppingListScreen(path: .constant([]))
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
    HomeView()
}
