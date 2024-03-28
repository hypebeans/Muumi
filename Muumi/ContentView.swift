//
//  ContentView.swift
//  Muumi
//
//  Created by Jonathan Budiman on 2024/02/13.
//

import SwiftUI
import RealmSwift

struct ContentView: View {
    
//    @State private var isLaunched: Bool = true
//    @State private var isFirstLaunch: Bool {
//        UserDefaults.standard.bool(forKey: "hasLaunched")
//    }
    @AppStorage("hasLaunched") private var isFirstLaunch: Bool = false
    
    var body: some View {
        
        if !isFirstLaunch { //TODO: ユーザーデーターベースの作成したら、変更
            OnboardView(isFirstLaunch : $isFirstLaunch)
        } else {
            HomeView()
        }
        
        
        
        
        
    }
}

#Preview {
    ContentView()
}
