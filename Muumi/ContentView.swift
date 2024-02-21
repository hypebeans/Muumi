//
//  ContentView.swift
//  Muumi
//
//  Created by Jonathan Budiman on 2024/02/13.
//

import SwiftUI
import RealmSwift

struct ContentView: View {
    
    @State private var isLaunched: Bool = true
    
    var body: some View {
        
        if isLaunched { //TODO: ユーザーデーターベースの作成したら、変更
            OnboardView()
        } else {
            HomeView()
        }
        
        
        
        
        
    }
}

#Preview {
    ContentView()
}
