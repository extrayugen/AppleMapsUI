//
//  MapButtonSingleView.swift
//  AppleMapUIKit
//
//  Created by Djallil Elkebir on 2023-01-10.
//

import SwiftUI

struct MapSingleButtonView: View {
    let icon: String
    let action: () -> Void
    var body: some View {
        Button(action:{}) {
            Image(systemName: icon)
                .foregroundColor(.white)
                .padding()
                .background(Color.gray)
                .frame(width: 44, height: 44)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .padding()
        }
    }
}

struct MapButtonSingleView_Previews: PreviewProvider {
    static var previews: some View {
        MapSingleButtonView(icon: "plus") {}
    }
}
