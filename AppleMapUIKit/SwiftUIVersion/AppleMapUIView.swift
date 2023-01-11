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
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Map(coordinateRegion: $viewModel.region)
                .sheet(isPresented: $showSheet) {
                    BottomSheetMainView(searchText: $searchText)
                    {
                        dismiss()
                        showSheet = false
                    }
                    .presentationDetents([.small,.customMedium, .customLarge], selection: $viewModel.currentDetent)
                    // stop the dismissal of the view when we tap the map
                    .interactiveDismissDisabled(true)
                    .onChange(of: viewModel.currentDetent) { newValue in
                        viewModel.getCurrentSheetHeight()
                    }
                    
                }
                .edgesIgnoringSafeArea(.all)
            MapButtons(sheetHeight: $viewModel.currentSheetHeight) {
                dismiss()
            }
        }
        .onAppear {
            showSheet = true
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
