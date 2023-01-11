//
//  TestView.swift
//  CVGenerator
//
//  Created by Djallil Elkebir on 2023-01-03.
//

import SwiftUI
import MapKit

struct AppleMapUIView: View {
    @StateObject private var viewModel = SwiftUIMainViewModel()
    @State private var showSheet = true
    @State private var searchText = ""
    
    var body: some View {
        ZStack {
            Map(coordinateRegion: $viewModel.region)
                .sheet(isPresented: $showSheet) {
                    BottomSheetMainView(searchText: $searchText)
                        .presentationDetents([.small,.customMedium, .customLarge], selection: $viewModel.currentDetent)
                    // stop the dismissal of the view when we tap the map
                        .interactiveDismissDisabled(true)
                        .onChange(of: viewModel.currentDetent) { newValue in
                            viewModel.getCurrentSheetHeight()
                        }
                }
                .edgesIgnoringSafeArea(.all)
            MapButtons(sheetHeight: $viewModel.currentSheetHeight)
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AppleMapUIView()
        }
    }
}

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

struct MapButtons: View {
    @Binding var sheetHeight: CGFloat
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
                    // do something
                }
                .offset(y: CGFloat(-sheetHeight))
                .padding()
                Spacer()
                MapSingleButtonView(icon: "map.fill") {
                    // do something
                }
                .offset(y: -sheetHeight)
                .padding(.trailing)
            }
        }
    }
}
