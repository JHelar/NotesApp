//
//  HideableSearchTextField.swift
//  iosApp
//
//  Created by John Larsson on 2023-04-24.
//  Copyright © 2023 orgName. All rights reserved.
//

import SwiftUI

struct SearchTextField: View {
    @Binding var searchText: String
    
    var body: some View {
        HStack {
            TextField("Search...", text: $searchText)
                .textFieldStyle(.roundedBorder)
            Button(action: {
                if !searchText.isEmpty {
                    $searchText.wrappedValue = ""
                }
            }) {
                Image(systemName: !searchText.isEmpty ? "xmark" : "magnifyingglass")
                    .foregroundColor(.black)
            }
        }
    }
}

struct HideableSearchTextField_Previews: PreviewProvider {
    static var previews: some View {
        SearchTextField(
            searchText: .constant("Hello from preview")
        )
    }
}
