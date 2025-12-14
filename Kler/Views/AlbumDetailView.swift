//
//  AlbumDetailView.swift
//  Kler
//
//  Created by Catalina on 11/16/25.
//

import SwiftUI
import SwiftData

struct AlbumDetailView: View {
    let category: String

    @Environment(\.modelContext) private var context
    @Query private var items: [ClothingItem]

    private let columns = [GridItem(.flexible()), GridItem(.flexible())]

    init(category: String) {
        self.category = category
        _items = Query(filter: #Predicate { $0.category == category })
    }

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(items) { item in
                    NavigationLink {
                        ClosetDetailView(item: item)
                    } label: {
                        VStack {
                            itemImage(item)

                            Text(item.name)
                                .font(.headline)

                            SustainabilityBadge(level: item.sustainabilityLevel)
                        }
                    }
                    .swipeActions {
                        Button(role: .destructive) {
                            context.delete(item)
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
                }
            }
            .padding()
        }
        .navigationTitle(category)
        .toolbar {
            // + BUTTON FOR ADD NEW ITEM
            NavigationLink {
                AddClothingView(category: category)
            } label: {
                Image(systemName: "plus")
            }
        }
    }

    private func itemImage(_ item: ClothingItem) -> some View {
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
}

#Preview {
    NavigationStack {
        AlbumDetailView(category: "Tops")
    }
    .modelContainer(for: ClothingItem.self, inMemory: true)
    .environmentObject(ClosetViewModel())
}
