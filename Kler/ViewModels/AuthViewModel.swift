//
//  AuthViewModel.swift
//  Kler
//
//  Created by Catalina on 12/1/25.
//

import Foundation
import FirebaseAuth
import Combine

@MainActor
class AuthViewModel: ObservableObject {

    @Published var email: String = ""
    @Published var password: String = ""
    @Published var displayName: String = ""

    @Published var isAuthenticated: Bool = false

    var username: String {
        if !displayName.trimmingCharacters(in: .whitespaces).isEmpty {
            return displayName
        }
        let raw = email.split(separator: "@").first.map(String.init) ?? ""
        return raw.isEmpty ? "Kler User" : raw.capitalized
    }


    func signIn() async {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.displayName = result.user.displayName ?? ""
            self.isAuthenticated = true
        } catch {
            print("❌ Sign in failed:", error.localizedDescription)
        }
    }

    func signUp() async {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)

            if !displayName.isEmpty {
                let change = result.user.createProfileChangeRequest()
                change.displayName = displayName
                try await change.commitChanges()
            }

            self.isAuthenticated = true
        } catch {
            print("❌ Sign up failed:", error.localizedDescription)
        }
    }

    func signOut() {
        do {
            try Auth.auth().signOut()
            isAuthenticated = false
            password = ""
        } catch {
            print("❌ Sign out failed:", error.localizedDescription)
        }
    }
}
