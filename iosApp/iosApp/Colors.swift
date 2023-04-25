//
//  Colors.swift
//  iosApp
//
//  Created by John Larsson on 2023-04-24.
//  Copyright © 2023 orgName. All rights reserved.
//

import Foundation
import SwiftUI

extension Color {
    init(hex: Int64) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: Double((hex >> 24) & 0xff) / 255
        )
    }
}
