//
//  MultilineTextField.swift
//  iosApp
//
//  Created by John Larsson on 2023-04-25.
//  Copyright © 2023 orgName. All rights reserved.
//

import SwiftUI

struct MultilineTextField: View {
    @Binding var text: String
    
    @State var isFocused: Bool = false
    
    var body: some View {
        if #available(iOS 16.0, *) {
            TextEditor(text: $text)
                .scrollContentBackground(Visibility.hidden)
        } else {
            // Fallback on earlier versions
        }
    }
}

struct MultilineTextField_Previews: PreviewProvider {
    static var previews: some View {
        MultilineTextField(text: .constant("Hello from preview"))
    }
}
