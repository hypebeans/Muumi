//
//  OnboardView.swift
//  Muumi
//
//  Created by Jonathan Budiman on 2024/02/18.
//

import SwiftUI

struct OnboardView: View {
    
    @State private var index = 0
    @State private var selectedIndex = 0
    @State private var isDone = false
    @Binding var isFirstLaunch: Bool
    private let intros: [Introduction] = Introduction.onboards
    private let dot = UIPageControl.appearance()
    
    var body: some View {
        NavigationStack {
            TabView(selection: $index) {
                ForEach(intros) { intro in
                    VStack {
                        Spacer()
                        IntroView(intro: intro)
                        Spacer()
                    }
                    .tag(intro.order)
                }
            }
            .animation(.easeInOut, value: index) // 次へまたは前のへ
            .indexViewStyle(.page(backgroundDisplayMode: .interactive))
            .tabViewStyle(PageTabViewStyle())
            .onChange(of: selectedIndex) { currOrder in
                index = currOrder
            }
            .onAppear {
                dot.currentPageIndicatorTintColor = .primary
                dot.pageIndicatorTintColor = .gray
            }
            Spacer()
            if index == intros.count - 1 {
                Button(action: {
                    skipIntro()
                }) {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color("PrimaryColor"))
                        .frame(width: .infinity, height: 60, alignment: .center)
                        .overlay(
                            Text("OK")
                                .font(.custom(Font.futura, size: 20))
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                        )
                        .padding()
                }
            } else {
                Button(action: {
                    nextIntro()
                }) {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color("PrimaryColor"))
                        .frame(width: .infinity, height: 60, alignment: .center)
                        .overlay(
                            Text("次へ")
                                .font(.custom(Font.futura, size: 20))
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                        )
                        .padding()
                }
            }
        }
        .navigationBarBackButtonHidden()
        .fullScreenCover(isPresented: $isDone, content: {
            HomeView()
        })
        .ignoresSafeArea()
        
    }
    private func nextIntro() {
        index += 1
    }
    
    private func resetIntro() {
        index = 0
    }
    
    private func skipIntro() {
        isFirstLaunch = true //初期化のラウンチ
//        UserDefaults.standard.set(true, forKey: "hasLaunched")
        isDone = true
    }
    
}

#Preview {
    OnboardView(isFirstLaunch: .constant(false))
}
