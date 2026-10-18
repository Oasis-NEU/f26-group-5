//
//  ContentView.swift
//  FoodBuddy
//
//  Created by James . on 10/13/26.
//

import SwiftUI
import Supabase

struct ContentView: View {
    @State var meetings: [Meeting] = []
    @State var users: [User] = []
    @State var inputText: String = ""
    
    var body: some View {
        VStack {
            HStack {
                List(users) { user in
                    Text(user.name)
                }
                .task {
                    do {
                        users = try await supabase.from("users").select().execute().value
                    } catch {
                        
                    }
                }
                List(meetings) { meeting in
                    List(meeting.users) { user in
                        Text(user.name)
                    }
                }
                .task {
                    do {
                        users = try await supabase.from("meetings").select().execute().value
                    } catch {
                        
                    }
                }
            }
            TextField("Insert User name", text: $inputText)
            Button("Add user") {
                Task {
                    await TH.addUser(name: inputText, email: "\(inputText)@gmail.com", year: 2030, gender: "male", interests: [])
                }
            }
            Button("Create meeting of current users") {
                Task {
                    await TH.addMeeting(date: Date.now, location: Location.StetsonEast, users: users)
                }
            }
        }
    }
}
