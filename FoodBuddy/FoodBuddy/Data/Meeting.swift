//
//  Meeting.swift
//  FoodBuddy
//
//  Created by James . on 10/18/26.
//
import Foundation

struct Meeting: Codable, Identifiable {
    var id: UUID
    
    var date: Date
    var location: DiningLocation
    var users: [User]
}
