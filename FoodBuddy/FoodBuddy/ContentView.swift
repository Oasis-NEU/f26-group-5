//
//  ContentView.swift
//  FoodBuddy
//
//  Created by James . on 10/13/26.
//

import SwiftUI
import Supabase

struct ContentView: View {
    @Environment(AuthManager.self) private var auth
    let supabase = SupabaseClient(
        supabaseURL: URL(string: "https://qsdbxsyhzuguzuroqndy.supabase.co")!,
        supabaseKey: "sb_publishable_jLRZ5xEia6HOdaHvaPUSHA_uAVVlYP1"
    )
    
    var body: some View {
        VStack {
            
        }.task {
            do {
                try await auth.signUp(email: "test5@northeastern.edu", password: "password123")
                print("signed up, state:", auth.state)
            } catch {
                print("sign up failed:", error)
            }
        }
    }
}
