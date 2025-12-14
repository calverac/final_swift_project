//
//  FeedView.swift
//  Kler
//
//  Created by Catalina on 11/6/25.
//

import SwiftUI
import SwiftData

struct FeedView: View {

    @Query(filter: #Predicate<ClothingItem> { $0.isListed })
    private var listedItems: [ClothingItem]

    @StateObject private var vm = FeedViewModel()

    var body: some View {
        NavigationStack {
            List {

                if !listedItems.isEmpty {
                    Section("Your listings") {
                        ForEach(listedItems) { item in
                            NavigationLink {
                                ClosetDetailView(item: item)
                            } label: {
                                listingRow(item)
                            }
                        }
                    }
                }

                Section("Community listing highlights") {
                    ForEach(vm.communityPosts) { post in
                        communityRow(post)
                    }
                }

                Section("Sustainability tips") {
                    ForEach(vm.currentTips, id: \.self) { tip in
                        Text("• \(tip)")
                    }
                }
            }
            .navigationTitle("Feed")
            .onAppear { vm.generateNewTips() }
        }
    }

    private func listingRow(_ item: ClothingItem) -> some View {
        HStack {
            itemThumb(item)
            VStack(alignment: .leading) {
                Text(item.name).bold()
                Text(item.category).font(.subheadline).foregroundStyle(.secondary)
            }
            Spacer()
            SustainabilityBadge(level: item.sustainabilityLevel)
        }
    }

    private func itemThumb(_ item: ClothingItem) -> some View {
        Group {
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
        .frame(height: 110)
        .clipped()
        .cornerRadius(12)
    }

    private func communityRow(_ post: FeedPost) -> some View {
        HStack {
            Image(post.imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 60, height: 60)
                .cornerRadius(10)

            VStack(alignment: .leading) {
                Text(post.title).bold()
                Text(post.username).foregroundStyle(.secondary)
                Text(post.description).font(.footnote)
            }
        }
    }
}


#Preview {
    FeedView()
        .modelContainer(for: ClothingItem.self, inMemory: true)
}
