//
//  MeetingBlockCardView.swift
//  FoodBuddy
//
//  Created by James . on 11/13/26.
//
import SwiftUI
import Foundation

struct MeetingBlockCardView: View {
    var meeting: Meeting
    
    var body: some View {
        Text(meeting.mealType)
        Text(meeting.date, style: .time)
        if meeting.mostCommonInterest != nil {
            Text(meeting.mostCommonInterest.rawValue)
        }
    }
}
