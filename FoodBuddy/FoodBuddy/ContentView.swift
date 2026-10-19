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
                        print("Error loading users: \(error)")
                    }
                }
                List(meetings) { meeting in
                    Section(meeting.location.rawValue) {
                        ForEach(meeting.users) { user in
                            Text(user.name)
                        }
                    }
                }
                .task {
                    do {
                        meetings = try await supabase
                            .from("meetings")
                            .select("id, date, location, users(*)")
                            .execute()
                            .value
                    } catch {
                        print("Error loading meetings: \(error)")
                    }
                }
            }
            TextField("Insert User name", text: $inputText)
            Button("Add user") {
                Task {
                    await TH.addUser(name: inputText, email: "\(inputText)@gmail.com", year: 2030, gender: "male", interests: [])
                    users = (try? await supabase.from("users").select().execute().value) ?? users
                }
            }
            Button("Create meeting of current users") {
                Task {
                    await TH.addMeeting(date: Date.now, location: DiningLocation.stetson_east, users: users)
                    meetings = (try? await supabase.from("meetings").select("id, date, location, users(*)").execute().value) ?? meetings
                }
            }
        }
    }
}
