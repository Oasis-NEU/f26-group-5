//
//  FoodBuddyApp.swift
//  FoodBuddy
//
//  Created by James . on 10/13/26.
//

import SwiftUI
import Foundation
import Supabase

@main
struct FoodBuddyApp: App {
    let supabase: SupabaseClient
    @State private var auth: AuthManager

    init() {
        let client = SupabaseClient(
            supabaseURL: URL(string: "https://qsdbxsyhzuguzuroqndy.supabase.co")!,
            supabaseKey: "sb_publishable_jLRZ5xEia6HOdaHvaPUSHA_uAVVlYP1"
        )
        self.supabase = client
        _auth = State(initialValue: AuthManager(client: client))
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(auth)
        }
    }
}
