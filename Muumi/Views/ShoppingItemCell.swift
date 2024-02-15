//
//  ShoppingItemCell.swift
//  Muumi
//
//  Created by Jonathan Budiman on 2024/02/15.
//

import SwiftUI

struct ShoppingItemCell: View {
    
    
    let item: ShoppingItem
    var selected: Bool
    let isSelected: (Bool) -> Void
    var body: some View {
        HStack {
            Image(systemName: selected ? "checkmark.square" : "square")
                .onTapGesture {
                    isSelected(!selected)
                }
            
            VStack(alignment: .leading) {
                Text(item.title)
                Text(item.category)
                    .opacity(0.4)
            }
            Spacer()
            Text("\(item.quantity)")
        }.opacity(selected ? 0.4 : 1.0)
    }
}

#Preview {
    ShoppingItemCell(item: ShoppingItem(), selected: true, isSelected: { _ in })
}
