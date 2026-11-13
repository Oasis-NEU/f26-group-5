//
//  MeetingBlockCardView.swift
//  FoodBuddy
//
//  Created by James . on 11/13/26.
//
import SwiftUI
import Foundation
import Supabase

struct MeetingBlockCardView: View {
    var meeting: Meeting
    var manager: MeetingManager
    
    var body: some View {
        Text(meeting.mealType)
        Text(meeting.date, style: .time)
        if meeting.mostCommonInterest != nil {
            Text(meeting.mostCommonInterest.rawValue)
        }
        Button("Join") {
            Task {
                try await manager.register(for: meeting) // TODO: error handling
            }
        }
    }
}
