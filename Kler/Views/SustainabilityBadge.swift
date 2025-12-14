//
//  SustainabilityBadge.swift
//  Kler
//
//  Created by Catalina on 11/18/25.
//

import SwiftUI

struct SustainabilityBadge: View {
    let level: SustainabilityLevel

    var body: some View {
        Text(level.label)
            .font(.caption)
            .padding(6)
            .background(level.color.opacity(0.2))
            .foregroundColor(level.color)
            .clipShape(Capsule())
    }
}

#Preview {
        SustainabilityBadge(level: .green)
}
