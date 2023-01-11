//
//  HorizontalSearchListRow.swift
//  AppleMapsUI
//
//  Created by Djallil Elkebir on 2023-01-07.
//

import SwiftUI

struct HorizontalSearchListRow: View {
    let recentSearch: HorizontalSearchModel
    var body: some View {
        HStack {
            Image(systemName: recentSearch.type.icon)
                .padding(8)
                .foregroundColor(.white)
                .background(recentSearch.type == .special ? Color.purple : Color.secondary)
                .background(recentSearch.type == .special ? .regularMaterial : .thinMaterial)
                .clipShape(Circle())
            VStack(alignment: .leading) {
                Text(recentSearch.name)
                if let subtitile = recentSearch.subtitle {
                    Text(subtitile)
                        .font(.callout)
                        .foregroundColor(.secondary)
                }
            }
            Spacer()
        }
    }
}

struct HorizontalSearchListRow_Previews: PreviewProvider {
    static var previews: some View {
        HorizontalSearchListRow(recentSearch: HorizontalSearchModel.sampleData.first!)
    }
}
