//
//  ProfileView.swift
//  Kler
//
//  Created by Catalina on 11/6/25.
//

import SwiftUI
import SwiftData

struct ProfileView: View {
    @EnvironmentObject var authVM: AuthViewModel
    @Query private var items: [ClothingItem]

    private let vm = ProfileViewModel()

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {

                    headerSection

                    shelf(title: "Most used", items: vm.topUsed(items: items))
                    shelf(title: "Least used", items: vm.leastUsed(items: items))
                    shelf(title: "Current listings", items: vm.listed(items: items))
                }
                .padding()
            }
            .navigationTitle("Profile")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Sign Out") {
                        authVM.signOut()
                    }
                }
            }
        }
    }

    private var headerSection: some View {
        HStack(spacing: 16) {
            Image(systemName: "person.crop.circle.fill")
                .font(.system(size: 56))
                .foregroundStyle(.teal)

            VStack(alignment: .leading, spacing: 4) {
                Text(authVM.username)
                    .font(.title2.bold())

                let avgScore = items.isEmpty ? 0 :
                    items.map(\.sustainabilityScore).reduce(0, +) / items.count

                Text("Average score: \(avgScore)")
                    .font(.subheadline)

                let donated = items.filter { $0.donated }.count
                let listed = items.filter { $0.isListed }.count

                Text("Donated: \(donated) • Listed: \(listed)")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }

            Spacer()
        }
    }

    private func shelf(title: String, items: [ClothingItem]) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(items) { item in
                        NavigationLink {
                            ClosetDetailView(item: item)
                        } label: {
                            VStack(alignment: .leading, spacing: 4) {
                                if let data = item.imageData,
                                   let ui = UIImage(data: data) {
                                    Image(uiImage: ui)
                                        .resizable()
                                        .scaledToFill()

                                } else if let asset = item.assetImageName {
                                    Image(asset)
                                        .resizable()
                                        .scaledToFill()

                                } else {
                                    Rectangle()
                                        .fill(Color.gray.opacity(0.2))
                                        .overlay(
                                            Image(systemName: "tshirt")
                                                .font(.largeTitle)
                                                .foregroundStyle(.secondary)
                                        )
                                }
                            }
                                Text(item.name)
                                    .font(.subheadline)
                                    .lineLimit(1)

                                Text("Uses: \(item.usesThisMonth)")
                                    .font(.caption)
                                    .foregroundStyle(colorForUses(item.usesThisMonth))
                            }
                        }
                    }
                }
            }
        }
    }

    private func colorForUses(_ uses: Int) -> Color {
        switch uses {
        case 5...: return .green
        case 1...4: return .yellow
        default: return .red
        }
    }


#Preview {
    ProfileView()
        .modelContainer(for: ClothingItem.self, inMemory: true)
}
