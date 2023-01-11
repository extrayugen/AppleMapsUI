//
//  MainViewModel.swift
//  AppleMapsUI
//
//  Created by Djallil Elkebir on 2023-01-07.
//

import SwiftUI
import Combine
import MapKit

class SwiftUIMainViewModel: ObservableObject {
    @Published var showSheet: Bool = true
    @Published var currentSheetHeight: CGFloat = 0
    @Published var currentDetent: PresentationDetent = .small
    // Apple Park Region
    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 37.334_900,
            longitude: -122.009_020),
        latitudinalMeters: 750,
        longitudinalMeters: 750
    )
    
    private var subscriptions = Set<AnyCancellable>()
    
    var context: PresentationDetent.Context? = nil
    init() {
        setObservers()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.getCurrentSheetHeight()
        }
    }
    
    private func setObservers() {
        NotificationCenter.default.publisher(for: .getContext)
            .receive(on: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] notificationObject in
                guard let self = self else { return }
                if let context = notificationObject.object as? PresentationDetent.Context {
                    if self.context?.description != context.description {
                        self.context = context
                    }
                }
            }.store(in: &subscriptions)
    }
    
    func getCurrentSheetHeight() {
        if let context = context {
            switch currentDetent {
            case .small:
                withAnimation {
                    currentSheetHeight = SmallDetent.height(in: context) ?? currentSheetHeight
                }
            case .customMedium:
                withAnimation {
                    currentSheetHeight = MediumDetent.height(in: context) ?? currentSheetHeight
                }
            case .customLarge:
                return
            default:
                return
            }
        }
    }
}

