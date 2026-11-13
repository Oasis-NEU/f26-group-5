//
//  Meeting.swift
//  FoodBuddy
//
//  Created by James . on 10/18/26.
//
import Foundation

struct Meeting: Codable, Identifiable, Hashable {
    var id: UUID
    
    var date: Date
    var location: DiningLocation
    var users: [User]
    
    var mealType: String {
        switch Calendar.current.component(.hour, from: date) {
        case 6..<11: "Breakfast"
        case 11..<17: "Lunch"
        case 17..<22: "Dinner"
        default: "Meal"
        }
    }
    
    var mostCommonInterest: Interest? {
        var counts: [Interest: Int] = [:]

        for user in users {
            for interest in user.interests {
                counts[interest, default: 0] += 1
            }
        }

        return counts.max(by: { $0.value < $1.value })?.key
    }
    
    // MARK: Conformances
    
    static func == (lhs: Meeting, rhs: Meeting) -> Bool {
        if lhs.id == rhs.id {
            return true
        } else {
            return false
        }
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(date)
        hasher.combine(location)
        hasher.combine(users)
    }
}
