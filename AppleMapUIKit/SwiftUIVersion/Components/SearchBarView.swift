//
//  SearchBarView.swift
//  AppleMapsUI
//
//  Created by Djallil Elkebir on 2023-01-07.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var text: String
    @State private var isEditing = false
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.secondary)
                .padding(.leading, 8)
            TextField("Search ...", text: $text)
                .padding(7)
                .padding(.trailing, 25)
                .padding(.horizontal, 10)
                .onTapGesture {
                    self.isEditing = true
                }
            
            if isEditing {
                Button(action: {
                    self.isEditing = false
                    self.text = ""
                }) {
                    Image(systemName: "xmark")
                }
                .padding(.trailing, 10)
                .transition(.move(edge: .trailing))
                .animation(.default, value: text)
            }
        }.background(Color.black.blendMode(.overlay))
            .cornerRadius(8)
    }
}


struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(text: .constant(""))
    }
}
