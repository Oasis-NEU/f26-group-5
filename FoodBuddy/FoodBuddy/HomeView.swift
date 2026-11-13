//
//  HomeView.swift
//  FoodBuddy
//
//  Created by James . on 11/12/26.
//
import SwiftUI
import Foundation

struct HomeView: View {
    var manager: MeetingManager
    
    var body: some View {
        ScrollView {
            greeting
            todaysPlans
            availableToday
        }
    }
    
    // MARK: View Components
    
    var greeting: some View {
        Text("Good Morning, \n ") // name here somehow
    }
    
    var todaysPlans: some View {
        ForEach(getMyMeetings(), id: \.self) { meeting in
            MeetingHorizontalCardView(meeting: meeting)
        }
    }
    
    var availableToday: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            ForEach(getNotMyMeetings(), id: \.self) { meeting in
                MeetingBlockCardView(meeting: meeting, manager: manager)
            }
        }
    }
    
    // MARK: Helpers
    
    func getMyMeetings() -> [Meeting] { // return all meetings this user is in
        var mine: [Meeting] = []
        for meeting in manager.meetings {
            if manager.isRegistered(for: meeting) {
                mine.append(meeting)
            }
        }
        return mine
    }
    
    func getNotMyMeetings() -> [Meeting] { // return all meetings this user is not in
        var notMine: [Meeting] = []
        for meeting in manager.meetings {
            if !manager.isRegistered(for: meeting) {
                notMine.append(meeting)
            }
        }
        return notMine
    }
}
