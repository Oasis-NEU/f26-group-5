//
//  EventManager.swift
//  FoodBuddy
//
//  Created by James . on 11/6/26.
//
import Supabase
import Foundation

class EventManager {
    init(client: SupabaseClient) {
        self.client = client
    }
    
    let client: SupabaseClient
}
