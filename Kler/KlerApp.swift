//
//  KlerApp.swift
//  Kler
//
//  Created by Catalina on 11/6/25.
//

import SwiftUI
import SwiftData

@main
struct KlerApp: App {

    @StateObject private var authVM = AuthViewModel()
    @StateObject private var closetVM = ClosetViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authVM)
                .environmentObject(closetVM)
        }
        .modelContainer(for: ClothingItem.self)
    }
}
