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
            
        }
    }
}

