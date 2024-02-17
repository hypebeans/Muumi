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
}
