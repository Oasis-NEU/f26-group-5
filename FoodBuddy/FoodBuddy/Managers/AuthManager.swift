//
//  SupabaseManager.swift
//  FoodBuddy
//
//  Created by James . on 11/6/26.
//
import Foundation
import Observation
import Supabase

@MainActor
@Observable
final class AuthManager {
    enum State {
        case loading
        case signedOut
        case needsProfile
        case signedIn(User) // holds the user itself
        case failed(String) // coudlnt load profile, holds the error text
    }

    private(set) var state: State = .loading // start ambiguous
    var errorMessage: String?

    var currentUser: User? {
        if case .signedIn(let user) = state { // if currently signed in
            return user
        }
        return nil
    }

    private let client: SupabaseClient

    init(client: SupabaseClient) {
        self.client = client
        Task { await listenForAuthChanges() } // will run in background forever, even after init breaks
    }

    // MARK: - Listening

    private func listenForAuthChanges() async {
        for await (event, session) in client.auth.authStateChanges { // a "stream" of supabase auth updates
            switch event {
            case .initialSession, .signedIn:
                if let session {
                    await loadProfile(for: session.user.id)
                } else {
                    state = .signedOut
                }
            case .signedOut:
                state = .signedOut
            default:
                print("something weird came through authStateChanges: \(event)")
                break
            }
        }
    }

    private func loadProfile(for id: UUID) async {
        do {
            let rows: [User] = try await client // get all rows that are equal to this id
                .from("users")
                .select()
                .eq("id", value: id)
                .execute()
                .value
            if let profile = rows.first {
                state = .signedIn(profile)
            } else {
                state = .needsProfile
            }
        } catch {
            state = .failed(error.localizedDescription) // cant throw bc this is called in listenforauthchanges so this instead
        }
    }

    // MARK: - Actions

    func signIn(email: String, password: String) async throws {
        try await client.auth.signIn(email: email, password: password)
    }

    func signUp(email: String, password: String) async throws {
        try await client.auth.signUp(email: email, password: password)
    }

    func signOut() async throws {
        try await client.auth.signOut()
    }

    func createProfile(name: String, year: Int, gender: String, interests: [Interest]) async throws {
        let authUser = try await client.auth.session.user

        let profile = User(
            id: authUser.id,
            name: name,
            email: authUser.email ?? "",
            year: year,
            gender: gender,
            interests: interests
        )

        try await client.from("users").insert(profile).execute()
        state = .signedIn(profile)
    }
}
