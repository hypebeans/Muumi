//
//  AddShoppingListScreen.swift
//  Muumi
//
//  Created by Jonathan Budiman on 2024/02/13.
//

import SwiftUI
import RealmSwift

struct AddShoppingListScreen: View {
    
    @Binding var path: [ViewPath]
    @State private var title: String = ""
    @State private var address: String = ""
    
    @ObservedResults(ShoppingList.self) var shoppingLists
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var showAlert = false
    @State var alertScale = 0.0
    @State var alertOpacity = 0.0
    @State private var isErrorShow = false
    @State private var alertMessage = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                Form {
                    TextField("Enter title", text: $title)
                    TextField("Enter address", text: $address)
                    
                    Button {
                        if title.isEmpty {
                            alertMessage = "Please enter your title!"
                            showAlert.toggle()
                        } else if address.isEmpty {
                            alertMessage = "Please enter your address!"
                            showAlert.toggle()
                        } else {
                            // ShoppingListレコード作成
                            let shoppingList = ShoppingList()
                            shoppingList.title = title
                            shoppingList.address = address
                            $shoppingLists.append(shoppingList)
                            
                            dismiss()
                        }
                    } label: {
                        Text("SAVE")
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            .frame(maxWidth: .infinity)
                    }.foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color("PrimaryColor"))
                        )
                    
                }
//                .navigationTitle("New List") //TODO: 変更
                .navigationBarItems(leading:
                    Image("New Shopping List")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .scaleEffect(1.5)
                        .frame(width: 150, height: 100)
                        .offset(x: 50)
                )
                .font(.custom("Futura", size: 20))
                .background(showAlert ? Color(.black) : Color(.clear))
                .opacity(showAlert ? 0.6 : 1)
                .disabled(showAlert ? true : false)
                
                if showAlert {
                    EmptyErrorAlert(path: $path, message: alertMessage)
                        .scaleEffect(alertScale)
                        .opacity(alertOpacity)
                        .onAppear() {
                            withAnimation(.easeInOut(duration: 0.5)) {
                                alertScale = 1.0
                                alertOpacity = 1.0
                            }
                        }
                        .onDisappear() {
                            alertScale = 0.0
                            alertOpacity = 0.0
                        }
                        .transition(.scale.combined(with: .opacity))
                }
            }
            
            
        }
        //    private func showAlert(message: String) {
        //        alertMessage = message
        //        showAlert = true
        //    }
    }
}
#Preview {
    AddShoppingListScreen(path: .constant([]))
}
