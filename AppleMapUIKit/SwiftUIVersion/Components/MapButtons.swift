//
//  MapButtons.swift
//  AppleMapUIKit
//
//  Created by Djallil Elkebir on 2023-01-10.
//

import SwiftUI

struct MapButtons: View {
    @Binding var sheetHeight: CGFloat
    let action: () -> Void
    var body: some View {
        VStack {
            HStack {
                Spacer()
                VStack {
                    VStack (spacing: 0){
                        Button(action:{}) {
                            Image(systemName: "map.fill")
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.gray)
                                .frame(width: 44, height: 44)
                        }
                        Divider()
                            .frame(width: 44, height: 2)
                            .foregroundColor(.white)
                        Button(action:{}) {
                            Image(systemName: "location")
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.gray)
                                .frame(width: 44, height: 44)
                        }
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .padding()
                    MapSingleButtonView(icon: "view.3d") {
                        // do something
                    }
                }
            }
            Spacer()
            HStack {
                MapSingleButtonView(icon: "binoculars.fill") {
                    action()
                }
                .offset(y: CGFloat(-sheetHeight))
                .padding()
                Spacer()
                MapSingleButtonView(icon: "map.fill") {
                    action()
                }
                .offset(y: -sheetHeight)
                .padding(.trailing)
            }
        }
    }
}


struct MapButtons_Previews: PreviewProvider {
    static var previews: some View {
        MapButtons(sheetHeight: .constant(300)) { }
    }
}
