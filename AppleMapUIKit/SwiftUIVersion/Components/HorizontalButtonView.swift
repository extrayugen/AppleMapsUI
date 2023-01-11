//
//  HorizontalButtonView.swift
//  AppleMapsUI
//
//  Created by Djallil Elkebir on 2023-01-07.
//

import SwiftUI

struct HorizontalButton: View {
    let icon: String
    let title: String
    let showAdd: Bool
    
    let action: () -> Void
    
    var body: some View {
        Button(action: {action()}) {
            VStack(spacing: 4){
                Image(systemName: icon)
                    .imageScale(.large)
                    .padding()
                    .background(Color(UIColor.systemBackground).blendMode(.overlay))
                    .clipShape(Circle())
                    .foregroundColor(Color.blue)
                Text(title)
                    .bold()
                    .font(.subheadline)
                if showAdd {
                    Text("Add")
                        .foregroundColor(.secondary)
                        .font(.caption)
                }
            }
        }
    }
}

struct HorizontalButtonView_Previews: PreviewProvider {
    static var previews: some View {
        HorizontalButton(icon: "plus", title: "Add", showAdd: false, action: {})
    }
}
