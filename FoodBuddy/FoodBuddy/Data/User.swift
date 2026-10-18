//
//  User.swift
//  FoodBuddy
//
//  Created by James . on 10/13/26.
//
import Foundation

struct User: Codable, Identifiable {
    let id: UUID
    
    var name: String
    var email: String
    var year: Int
    var gender: String
    var interests: [Interest]
}
