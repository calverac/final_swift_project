//
//  MapScreen.swift
//  Kler
//
//  Created by Catalina on 12/6/25.
//

import SwiftUI
import MapKit
import SwiftData

enum MapPinType {
    case donation
    case recycling
    case listing
    case community
}

struct MapPin: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
    let coordinate: CLLocationCoordinate2D
    let type: MapPinType
    let imageName: String?
}

struct MapScreen: View {
    @Query private var items: [ClothingItem]
    private let feedVM = FeedViewModel()

    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 42.3601, longitude: -71.0589),
        span: MKCoordinateSpan(latitudeDelta: 0.12, longitudeDelta: 0.12)
    )

    var pins: [MapPin] {
        var result: [MapPin] = []

        result.append(
            MapPin(
                title: "Goodwill Boston",
                subtitle: "Donation center",
                coordinate: .init(latitude: 42.3405, longitude: -71.0810),
                type: .donation,
                imageName: nil
            )
        )

        result.append(
            MapPin(
                title: "Goodwill Roxbury",
                subtitle: "Donation center",
                coordinate: .init(latitude: 42.3147, longitude: -71.0836),
                type: .donation,
                imageName: nil
            )
        )

        result.append(
            MapPin(
                title: "Textile Recycling Boston",
                subtitle: "Clothing recycling",
                coordinate: .init(latitude: 42.3210, longitude: -71.0960),
                type: .recycling,
                imageName: nil
            )
        )

        result.append(
            MapPin(
                title: "Cambridge Donation Hub",
                subtitle: "Recycling & donation",
                coordinate: .init(latitude: 42.3736, longitude: -71.1097),
                type: .recycling,
                imageName: nil
            )
        )

        for post in feedVM.communityPosts {
            result.append(
                MapPin(
                    title: post.title,
                    subtitle: post.username,
                    coordinate: post.coordinate,
                    type: .community,
                    imageName: post.imageName
                )
            )
        }

        for item in items {
            if item.isListed,
               let lat = item.listingLatitude,
               let lon = item.listingLongitude {

                result.append(
                    MapPin(
                        title: item.name,
                        subtitle: "Your listing",
                        coordinate: .init(latitude: lat, longitude: lon),
                        type: .listing,
                        imageName: nil
                    )
                )
            }
        }

        return result
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Map(coordinateRegion: $region, annotationItems: pins) { pin in
                    MapAnnotation(coordinate: pin.coordinate) {
                        VStack(spacing: 4) {
                            Image(systemName: symbol(for: pin.type))
                                .font(.title2)
                                .foregroundStyle(color(for: pin.type))
                                .padding(6)
                                .background(.thinMaterial)
                                .clipShape(Circle())

                            Text(pin.title)
                                .font(.caption2)
                                .fixedSize()
                        }
                    }
                }
                .ignoresSafeArea()

                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        VStack(spacing: 8) {
                            Button {
                                zoom(by: 0.5)
                            } label: {
                                Image(systemName: "plus.magnifyingglass")
                                    .padding(8)
                                    .background(.ultraThinMaterial)
                                    .clipShape(Circle())
                            }

                            Button {
                                zoom(by: 2.0)
                            } label: {
                                Image(systemName: "minus.magnifyingglass")
                                    .padding(8)
                                    .background(.ultraThinMaterial)
                                    .clipShape(Circle())
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Map")
        }
    }

    private func zoom(by factor: Double) {
        region.span.latitudeDelta *= factor
        region.span.longitudeDelta *= factor
    }

    private func color(for type: MapPinType) -> Color {
        switch type {
        case .donation: return .green
        case .recycling: return .blue
        case .listing: return .orange
        case .community: return .purple
        }
    }

    private func symbol(for type: MapPinType) -> String {
        switch type {
        case .donation: return "house.fill"
        case .recycling: return "arrow.3.trianglepath"
        case .listing: return "tshirt.fill"
        case .community: return "person.2.fill"
        }
    }
}


#Preview {
    MapScreen()
}
