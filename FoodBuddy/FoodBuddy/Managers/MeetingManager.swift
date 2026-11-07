//
//  EventManager.swift
//  FoodBuddy
//
//  Created by James . on 11/6/26.
//
import Foundation
import Observation
import Supabase

@MainActor
@Observable
final class MeetingManager {
    private(set) var meetings: [Meeting] = []

    private let client: SupabaseClient

    init(client: SupabaseClient) {
        self.client = client
    }

    func loadMeetings(includePast: Bool = false) async throws {
        var query = client
            .from("meetings")
            .select("id, date, location, users(*)")

        if !includePast {
            query = query.gte("date", value: Date().ISO8601Format()) // include all meetings before now
        }

        meetings = try await query
            .order("date")
            .execute()
            .value
    }
    
    func register(for meeting: Meeting) async throws {
        let userID = try await client.auth.session.user.id

        try await client
            .from("meeting_participants")
            .insert(ParticipantRow(meeting_id: meeting.id, user_id: userID))
            .execute()

        try await refresh(meeting.id)
    }

    func unregister(from meeting: Meeting) async throws {
        let userID = try await client.auth.session.user.id

        try await client
            .from("meeting_participants")
            .delete()
            .eq("meeting_id", value: meeting.id)
            .eq("user_id", value: userID)
            .execute()

        try await refresh(meeting.id)
    }

    private func refresh(_ meetingID: UUID) async throws { // to be run after registering or unregistering to update the list
        let updated: Meeting = try await client
            .from("meetings")
            .select("id, date, location, users(*)")
            .eq("id", value: meetingID)
            .single() // must be exactly one row
            .execute()
            .value

        if let index = meetings.firstIndex(where: { $0.id == meetingID }) {
            meetings[index] = updated
        }
    }
    
    func isRegistered(for meeting: Meeting) -> Bool { // is a user registered for the given meeting
        guard let myID = client.auth.currentUser?.id else { return false }
        return meeting.users.contains { $0.id == myID }
    }
}

private struct ParticipantRow: Encodable {
    let meeting_id: UUID
    let user_id: UUID
}
