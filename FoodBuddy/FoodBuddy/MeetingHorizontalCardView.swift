//
//  MeetingCardView.swift
//  FoodBuddy
//
//  Created by James . on 11/12/26.
//

import SwiftUI
import Foundation

struct MeetingHorizontalCardView: View {
    var meeting: Meeting
    
    var body: some View {
        HStack {
            Image(systemName: "fork.knife")
            VStack {
                HStack {
                    Text(meeting.date, style: .time)
                    Text("● \(meeting.location.rawValue)")
                }
                Text("\(meeting.mealType) with \(meeting.users.count) others")
            }
        }
    }
}

#Preview {
    MeetingHorizontalCardView(meeting: Meeting(id: UUID(), date: Date.now, location: .international_village, users: []))
}
