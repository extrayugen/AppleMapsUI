//
//  MainViewControllerViewModel.swift
//  AppleMapUIKit
//
//  Created by Djallil Elkebir on 2023-01-10.
//

import UIKit
import MapKit

class MainViewModel: NSObject, MKMapViewDelegate {
    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 37.334_900,
            longitude: -122.009_020),
        latitudinalMeters: 750,
        longitudinalMeters: 750
    )
}
