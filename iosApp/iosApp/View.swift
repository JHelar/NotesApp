//
//  TextEditorBackground.swift
//  iosApp
//
//  Created by John Larsson on 2023-04-24.
//  Copyright © 2023 orgName. All rights reserved.
//

import Foundation
import SwiftUI

extension UITextView {
  open override var frame: CGRect {
    didSet {
      backgroundColor = .clear
    }
  }
}
