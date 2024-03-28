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
    @Environment(\.dismiss) private var dismiss
    
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
//            .navigationBarBackButtonHidden(true)
//            .navigationBarTitle("", displayMode: .inline)
//            .navigationBarItems(leading:
//                                    Button(action: {
//                dismiss()
//            }) {
//                Image(systemName: "chevron.left")
//                    .foregroundColor(Color("PrimaryColor"))
//            })
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
            }.sheet(isPresented: $isPresented, content: {
                AddShoppingListScreen(path: .constant([]))
            })
            
        }
    }
}

#Preview {
    HomeView()
}
