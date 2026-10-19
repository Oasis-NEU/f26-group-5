//
//  TemporaryHelpers.swift
//  FoodBuddy
//
//  Created by James . on 10/18/26.
//
import Foundation
import Supabase

private struct MeetingRow: Encodable {
    let id: UUID
    let date: Date
    let location: DiningLocation
}

private struct ParticipantRow: Encodable {
    let meeting_id: UUID
    let user_id: UUID
}

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
    
    static func addMeeting(date: Date, location: DiningLocation, users: [User]) async {
        let meetingId = UUID()

        do {
            try await supabase
                .from("meetings")
                .insert(MeetingRow(id: meetingId, date: date, location: location))
                .execute()

            if !users.isEmpty {
                try await supabase
                    .from("meeting_participants")
                    .insert(users.map { ParticipantRow(meeting_id: meetingId, user_id: $0.id) })
                    .execute()
            }

            print("Successfully added meeting")
        } catch {
            print("Error inserting meeting: \(error)")
        }
    }
}
