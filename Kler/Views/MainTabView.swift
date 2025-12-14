//
//  MainTabView.swift
//  Kler
//
//  Created by Catalina on 11/6/25.
//

import SwiftUI
import SwiftData

struct MainTabView: View {
    @EnvironmentObject var authVM: AuthViewModel
    @EnvironmentObject var closetVM: ClosetViewModel

    var body: some View {
        TabView {
            ClosetView()
                .tabItem {
                    Label("Closet", systemImage: "tshirt.fill")
                }

            FeedView()
                .tabItem {
                    Label("Feed", systemImage: "person.2.wave.2.fill")
                }

            MapScreen()
                .tabItem {
                    Label("Map", systemImage: "map")
                }

            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.crop.circle")
                }
        }
    }
}

#Preview {
    MainTabView()
        .environmentObject(AuthViewModel())
        .environmentObject(ClosetViewModel())
        .modelContainer(for: ClothingItem.self, inMemory: true)
}
