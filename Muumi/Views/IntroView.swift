//
//  IntroView.swift
//  Muumi
//
//  Created by Jonathan Budiman on 2024/02/17.
//

import SwiftUI

struct IntroView: View {
    var intro: Introduction
    
    var body: some View {
        VStack(spacing: 30) {
            Image("\(intro.imageUrl)")
                .resizable()
                .scaledToFit()
                .padding()
            
            Text(intro.name)
                .font(.custom(Font.futura, size: 28))
                .fontWeight(.bold)
                .padding()
            
            Text(intro.description)
                .font(.custom(Font.futura, size: 16))
                .frame(width: 300)
                .padding()
            
        }
    }
}

#Preview {
    IntroView(intro: Introduction.sampleIntro)
}
