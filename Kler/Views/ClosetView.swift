//
//  ClosetView.swift
//  Kler
//
//  Created by Catalina on 12/6/25.
//

import SwiftUI
import SwiftData

struct ClosetView: View {
    @EnvironmentObject var closetVM: ClosetViewModel
    @Environment(\.modelContext) private var context
    @Query private var items: [ClothingItem]

    @State private var isEditingAlbums = false
    @State private var showingAddCategoryAlert = false
    @State private var newCategoryName = ""

    private let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(closetVM.categories, id: \.self) { category in
                        ZStack(alignment: .topTrailing) {
                            NavigationLink {
                                AlbumDetailView(category: category)
                            } label: {
                                VStack {
                                    coverImage(for: category)
                                        .frame(height: 110)
                                        .cornerRadius(12)

                                    Text(category)
                                        .font(.headline)
                                }
                            }

                            if isEditingAlbums {
                                Button {
                                    deleteCategory(category)
                                } label: {
                                    Image(systemName: "xmark.circle.fill")
                                        .foregroundStyle(.red)
                                        .padding(6)
                                }
                            }
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Closet")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(isEditingAlbums ? "Done" : "Edit") {
                        withAnimation { isEditingAlbums.toggle() }
                    }
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        newCategoryName = ""
                        showingAddCategoryAlert = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .alert("New Album", isPresented: $showingAddCategoryAlert) {
                TextField("Album name", text: $newCategoryName)
                Button("Cancel", role: .cancel) {}
                Button("Save") {
                    closetVM.addCategory(newCategoryName)
                }
            } message: {
                Text("Type a name for your new album.")
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

    private func deleteCategory(_ category: String) {
        let toDelete = items.filter { $0.category == category }
        toDelete.forEach { context.delete($0) }
        closetVM.removeCategory(category)
    }

    private func coverImage(for category: String) -> some View {
        let coverItem = items.first { $0.category == category }

        return Group {
            if let data = coverItem?.imageData,
               let ui = UIImage(data: data) {
                Image(uiImage: ui)
                    .resizable()
                    .scaledToFill()
            } else if let asset = coverItem?.assetImageName {
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
    }

}

#Preview {
    ClosetView()
        .modelContainer(for: ClothingItem.self, inMemory: true)
        .environmentObject(ClosetViewModel())
}
