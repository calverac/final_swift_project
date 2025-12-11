//
//  SustainabilityLevel.swift
//  Kler
//
//  Created by Catalina on 12/7/25.
//

import Foundation
import SwiftUI

enum SustainabilityLevel {
    case red
    case yellow
    case green

    var color: Color {
        switch self {
        case .red: return .red
        case .yellow: return .yellow
        case .green: return .green
        }
    }

    var label: String {
        switch self {
        case .red: return "Low Impact"
        case .yellow: return "Medium Impact"
        case .green: return "High Impact"
        }
    }
}
