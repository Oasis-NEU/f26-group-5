//
//  TemporaryHelpers.swift
//  FoodBuddy
//
//  Created by James . on 10/18/26.
//
import Foundation
import Supabase

struct TH {
    static func addUser(name: String, email: String, year: Int, gender: String, interests: [Interest]) async {
        let user = User(id: UUID(), name: name, email: email, year: year, gender: gender, interests: interests)
        
        do {
            try await supabase
                .from("users")
                .insert(user)
                .execute()
                
            print("Successfully added user")
        } catch {
            print("Error inserting user: \(error)")
        }
    }
    
    static func addMeeting(date: Date, location: Location, users: [User]) async {
        let meeting = Meeting(id: UUID(), date: date, location: location, users: users)
        
        do {
            try await supabase
                .from("meetings")
                .insert(meeting)
                .execute()
                
            print("Successfully added meeting")
        } catch {
            print("Error inserting meeting: \(error)")
        }
    }
}
