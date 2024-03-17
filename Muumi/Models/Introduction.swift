//
//  Introduction.swift
//  Muumi
//
//  Created by Jonathan Budiman on 2024/02/17.
//

import Foundation

struct Introduction: Identifiable, Equatable {
    let id = UUID()
    var name: String
    var description: String
    var imageUrl: String
    var order: Int
    
    static var sampleIntro = Introduction(name: "タイトル例", description: "これはデバッグのための記述例であるよ。", imageUrl: "Shop", order: 0)
        
        static var onboards: [Introduction] = [
            Introduction(name: "Muumiへようこそ！", description: "素晴らしいことが待っている！", imageUrl: "Shop", order: 0),
            Introduction(name: "簡単な生活ておトクに！", description: "安心して食料品を購入できる完璧な場所!", imageUrl: "Pay", order: 1),
            Introduction(name: "特別ものをお探しですか？", description: "注文に依頼を追加するにあれば、解決できます！", imageUrl: "Delivery", order: 2),
        ]
}
