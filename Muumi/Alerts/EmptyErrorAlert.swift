//
//  EmptyErrorAlert.swift
//  Muumi
//
//  Created by Jonathan Budiman on 2024/03/16.
//

import SwiftUI

struct EmptyErrorAlert: View {
    
    @Binding var path: [ViewPath]
    @Environment(\.dismiss) private var dismiss
    let message: String
    
    var body: some View {
        ZStack {
            VStack {
                Text("ERROR")
                    .font(.custom("Futura", size: 32))
                    .fontWeight(.black)
                    .foregroundColor(.white)
                    .padding()
                Spacer()
                Text(message)
                    .font(.custom("Futura", size: 18))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding()
                Spacer()
                Button(action: {
                    dismiss()                    
                }) {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color("SecondaryColor"))
                        .frame(width: 100, height: 50, alignment: .center)
                        .overlay (
                            Text("OK")
                                .font(.custom("Futura", size: 24))
                                .fontWeight(.black)
                                .foregroundColor(.white)
                        )
                }.padding()
                Spacer()
            }.frame(width: 320, height: 200)
                .padding(25)
                .background(Color("PrimaryColor"))
                .cornerRadius(20)
                
            //                .overlay {
            //                    Button(action: {
            //                        dismiss()
            //                    }) {
            //                        RoundedRectangle(cornerRadius: 20)
            //                            .fill(Color("SecondaryColor"))
            //                            .frame(width: 150, height: 70, alignment: .center)
            //                            .overlay (
            //                                Text("OK")
            //                                    .font(.custom("Futura", size: 24))
            //                                    .fontWeight(.black)
            //                                    .foregroundColor(.white)
            //                            )
            //                    }
            //                }
        }
        .overlay(alignment: .leading) {
            Image("Error")
                .scaleEffect(0.3)
                .offset(x:-30, y: -160)
        }
    }
}

#Preview {
    EmptyErrorAlert(path: .constant([.AddShoppingListScreen, .AddShoppingListItemScreen]) ,message: "Error message shown")
}
