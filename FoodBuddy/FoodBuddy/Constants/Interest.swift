//
//  Interest.swift
//  FoodBuddy
//
//  Created by James . on 10/13/26.
//
import Supabase

enum Interest: String, Codable, PostgrestFilterValue {
    case movies = "Movies"
    
    case engineering = "Engineering"
    case english = "English"
    
    case basketball = "Basketball"
    case football = "Football"
    case baseball = "Baseball"
    case soccer = "Soccer"
}
